terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "pjsf-terraform"
    key    = "terraform-cd/terraform.tfstate"
    region = "us-east-1"
  }
}

module "vpc_us" {
  source = "../modules/vpc"

  # pass variables to the vpc module
  region     = "us-east-1"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "VPC US"

  # Subnets
  pub_subnet_name = "Public Subnet"
  pub_subnet_az   = "us-east-1a"
  pub_subnet_cidr = "10.0.0.0/24"
  priv_subnets = {
    "private_subnet_1" = {
      name = "Private Subnet 1"
      az   = "us-east-1a"
      cidr = "10.0.1.0/24"
    },
    "private_subnet_2" = {
      name = "Private Subnet 2"
      az   = "us-east-1b"
      cidr = "10.0.2.0/24"
    },
    "private_subnet_3" = {
      name = "Private Subnet 3"
      az   = "us-east-1c"
      cidr = "10.0.3.0/24"
    }
  }
}

module "vpc_london" {
  source = "../modules/vpc"

  # Pass variables to the vpc module
  # VPC
  region     = "eu-west-2"
  cidr_block = "10.1.0.0/16"
  vpc_name   = "VPC London"

  # Subnets
  pub_subnet_name = "Public Subnet"
  pub_subnet_az   = "eu-west-2a"

  pub_subnet_cidr = "10.1.0.0/24"
  priv_subnets = {
    "private_subnet_1" = {
      name = "Private Subnet 1"
      az   = "eu-west-2a"
      cidr = "10.1.1.0/24"
    },
    "private_subnet_2" = {
      name = "Private Subnet 2"
      az   = "eu-west-2b"
      cidr = "10.1.2.0/24"
    },
    "private_subnet_3" = {
      name = "Private Subnet 3"
      az   = "eu-west-2c"
      cidr = "10.1.3.0/24"
    }
  }
}

module "vpc_sydney" {
  source = "../modules/vpc"

  # Pass variables to the vpc module
  # VPC
  region     = "ap-southeast-2"
  cidr_block = "10.2.0.0/16"
  vpc_name   = "VPC London"

  # Subnets
  pub_subnet_name = "Public Subnet"
  pub_subnet_az   = "ap-southeast-2a"

  pub_subnet_cidr = "10.2.0.0/24"
  priv_subnets = {
    "private_subnet_1" = {
      name = "Private Subnet 1"
      az   = "ap-southeast-2a"
      cidr = "10.2.1.0/24"
    },
    "private_subnet_2" = {
      name = "Private Subnet 2"
      az   = "ap-southeast-2b"
      cidr = "10.2.2.0/24"
    },
    "private_subnet_3" = {
      name = "Private Subnet 3"
      az   = "ap-southeast-2c"
      cidr = "10.2.3.0/24"
    }
  }
}
