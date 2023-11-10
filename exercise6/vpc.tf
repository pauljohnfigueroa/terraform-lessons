resource "aws_vpc" "terra" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "Terra-Vpc"
  }
}

# Public subnets
resource "aws_subnet" "terra-pub-1" {
  vpc_id                  = aws_vpc.terra.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE1

  tags = {
    Name = "terra-pub-1"
  }
}

resource "aws_subnet" "terra-pub-2" {
  vpc_id                  = aws_vpc.terra.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE2

  tags = {
    Name = "terra-pub-2"
  }
}

resource "aws_subnet" "terra-pub-3" {
  vpc_id                  = aws_vpc.terra.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE3

  tags = {
    Name = "terra-pub-3"
  }
}

# Private subnets
resource "aws_subnet" "terra-priv-1" {
  vpc_id                  = aws_vpc.terra.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE1

  tags = {
    Name = "terra-priv-1"
  }
}

resource "aws_subnet" "terra-priv-2" {
  vpc_id                  = aws_vpc.terra.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE2

  tags = {
    Name = "terra-priv-2"
  }
}

resource "aws_subnet" "terra-priv-3" {
  vpc_id                  = aws_vpc.terra.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE3

  tags = {
    Name = "terra-priv-3"
  }
}

# gateway
resource "aws_internet_gateway" "terra-gw" {
  vpc_id = aws_vpc.terra.id

  tags = {
    Name = "terra-gw"
  }
}

#route table
resource "aws_route_table" "terra-pub-rt" {
  vpc_id = aws_vpc.terra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-gw.id
  }

  tags = {
    Name = "terra-pub-rt"
  }
}

# route table association
resource "aws_route_table_association" "terra-pub-1-a" {
  subnet_id      = aws_subnet.terra-pub-1.id
  route_table_id = aws_route_table.terra-pub-rt.id
}

resource "aws_route_table_association" "terra-pub-2-a" {
  subnet_id      = aws_subnet.terra-pub-2.id
  route_table_id = aws_route_table.terra-pub-rt.id
}

resource "aws_route_table_association" "terra-pub-3-a" {
  subnet_id      = aws_subnet.terra-pub-3.id
  route_table_id = aws_route_table.terra-pub-rt.id
}