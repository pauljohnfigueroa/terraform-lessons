terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  instance_name = "${terraform.workspace}-instance"
}

resource "aws_instance" "webserver" {
  # ami           = "ami-0230bd60aa48260c6"
  ami = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "Paul Webserver"
  }
}