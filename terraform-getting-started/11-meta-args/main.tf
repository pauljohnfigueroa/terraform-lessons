# for version 0.13 and above
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# provider "aws" {
#   alias  = "us_west_1"
#   region = "us-west-1"
# }

locals {
  ingress_rules = [
    {
      port        = 80
      description = "Http"
    },
    {
      port        = 443
      description = "TLS"
    }
  ]
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My Vpc"
  }
}

# resource "aws_instance" "webserver_west" {
#   provider      = aws.us_west_1
#   ami           = "ami-0cbd40f694b804622"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "Server_west_1"
#   }
# }

# Using count
# resource "aws_instance" "webserver" {
#   count         = 2 # use count for identical resources
#   ami           = "ami-0230bd60aa48260c6"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "Server_${count.index}"
#   }
# }

# Using for_each
resource "aws_instance" "webserver" {
  for_each = {
    "prod" = "t2.small"
    "dev"  = "t2.micro"
  }

  ami           = "ami-0230bd60aa48260c6"
  instance_type = each.value

  tags = {
    Name = "Server_${each.key}"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  #   ingress {
  #     description      = "TLS from VPC"
  #     from_port        = 443
  #     to_port          = 443
  #     protocol         = "tcp"
  #     cidr_blocks      = [aws_vpc.main.cidr_block]
  #     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  #   }

  #   ingress {
  #     description      = "Http from Anywhere"
  #     from_port        = 80
  #     to_port          = 80
  #     protocol         = "tcp"
  #     cidr_blocks      = ["0.0.0.0/0"]
  #     ipv6_cidr_blocks = ["::/0"]
  #   }

  # dynamic block
  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description      = ingress.value.description
      from_port        = ingress.value.port
      to_port          = ingress.value.port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


# output "webservers" {
#   # value = aws_instance.webserver[0].public_ip
#   # value = aws_instance.webserver[*].public_ip # splat operator [*], return all instances in a list[]
# }

output "webservers" {
  value = aws_instance.webserver["prod"].public_ip
}

output "instances" {
  value = [for instance in aws_instance.webserver : instance.public_ip]
}

output "intance_west" {
  value = aws_instance.webserver_west.tags.Name
}

