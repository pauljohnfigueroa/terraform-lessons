terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
}

# Create a VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TerraformVpc"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "MainIgw"
  }
}

# Create a route table
resource "aws_route_table" "prod-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "TerraformProdRt"
  }
}

# Create a subnet
resource "aws_subnet" "prod-subnet-1" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "ProdSubnet1"
  }
}

# Associate subnet with a route table
resource "aws_route_table_association" "subnet1-rt-assoc" {
  subnet_id      = aws_subnet.prod-subnet-1.id
  route_table_id = aws_route_table.prod-rt.id
}

# Create security group to allow port 22, 80, 443
resource "aws_security_group" "allow_web_sg" {
  name        = "allow_web_traffic"
  description = "Allow Web Traffic"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowWeb"
  }
}

# Create a network interface
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.prod-subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web_sg.id]
}

# Create EIP
resource "aws_eip" "one" {
  domain                    = "vpc"
  instance                  = aws_instance.ubuntu.id
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.igw]
}

# Create a network interface 2
resource "aws_network_interface" "web-server2-nic" {
  subnet_id       = aws_subnet.prod-subnet-1.id
  private_ips     = ["10.0.1.49"]
  security_groups = [aws_security_group.allow_web_sg.id]
}

# Create EIP 2 
resource "aws_eip" "two" {
  domain                    = "vpc"
  instance                  = aws_instance.ubuntu2.id
  network_interface         = aws_network_interface.web-server2-nic.id
  associate_with_private_ip = "10.0.1.49"
  depends_on                = [aws_internet_gateway.igw]
}

# Create EC2 instance
resource "aws_instance" "ubuntu" {
  ami               = "ami-06aa3f7caf3a30282"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "terraform-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c "echo My Very First Web Server with Terraform >> /var/www/html/index.html"
                EOF
  tags = {
    Name = "TerraformInstance"
  }
}

# Create a 2nd EC2 instance
resource "aws_instance" "ubuntu2" {
  ami               = "ami-06aa3f7caf3a30282"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "terraform-key"

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c "echo My Very Second Web Server with Terraform >> /var/www/html/index.html"
                EOF

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server2-nic.id
  }

  tags = {
    Name = "TerraformInstance2"
  }
}

# OUTPUT
output "server_private_ip" {
  value = aws_instance.ubuntu.private_ip
}

output "server_public_ip" {
  value = aws_instance.ubuntu.public_ip
}

output "server_id" {
  value = aws_instance.ubuntu.id
}

# 2nd EC2 instance
output "server2_private_ip" {
  value = aws_instance.ubuntu2.private_ip
}

output "server2_public_ip" {
  value = aws_instance.ubuntu2.public_ip
}

output "server2_id" {
  value = aws_instance.ubuntu2.id
}