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

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
  tags = {
    Name = "My VPC"
  }
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.main.id
    availability_zone = "us-east-1b"
}


resource "aws_instance" "foobar" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  tags = {
    Name = "Foobar"
  }
}


