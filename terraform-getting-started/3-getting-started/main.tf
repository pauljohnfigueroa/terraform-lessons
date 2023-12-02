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

locals {
  company_name = "PurpleHaze Corp."
  foo          = upper("foobar")
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.company_name}_VPC"
    baz  = local.foo
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id # create this subnet in this VPC
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "${local.company_name}_Subnet_1"
    baz  = local.foo
  }
}

resource "aws_instance" "foobar" {
  ami                         = "ami-0230bd60aa48260c6"
  instance_type               = var.my_instance_type
  subnet_id                   = aws_subnet.subnet1.id # launch this instance in this instance
  associate_public_ip_address = true
  tags                        = var.instance_tags
}