terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}


# Create VPC resources for each region using for_each
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

# Public Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Public Route Table"
  }
}

# Public Route
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private Route Table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Public Route Table"
  }
}

# Create a Public Subnet
resource "aws_subnet" "pub_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_subnet_cidr
  availability_zone = var.pub_subnet_az

  map_public_ip_on_launch = true

  tags = {
    Name = var.pub_subnet_name
  }
}

# Create a Private Subnets
resource "aws_subnet" "private_subnets" {
  for_each = var.priv_subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = {
    Name = each.key
  }
}




