terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }

  backend "s3" {
    bucket = "pjsf-terraform"
    key    = "terraform-state/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "webserver" {
  # ami           = "ami-0230bd60aa48260c6"
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "Paul Webserver"
  }
}