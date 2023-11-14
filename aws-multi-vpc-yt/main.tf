terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

##############################################
# Providers                                  
#

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "useast2"
  region = "us-east-2"
}


##############################################
# VPCs                                  
#

# VPC
resource "aws_vpc" "earth_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "EarthVpc"
  }
}

# VPC
resource "aws_vpc" "mars_vpc" {
  provider         = aws.useast2
  cidr_block       = "20.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "MarsVpc"
  }
}

##############################################
# Subnets                                  
#

# Subnet
resource "aws_subnet" "earth_pubsn1" {
  vpc_id            = aws_vpc.earth_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "EarthVpcPubSn1"
  }
}

# Subnet
resource "aws_subnet" "mars_pubsn1" {
  provider          = aws.useast2
  vpc_id            = aws_vpc.mars_vpc.id
  cidr_block        = "20.0.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "MarsVpcPubSn1"
  }
}

##############################################
# VPC Peerings                              
#

# VPC Peering Earth to Mars Requester
resource "aws_vpc_peering_connection" "earth-mars-peering" {
  peer_vpc_id = aws_vpc.mars_vpc.id # remote
  vpc_id      = aws_vpc.earth_vpc.id # local
  peer_region = "us-east-2"

  tags = {
    Name = "Earth-Mars-Peering"
  }
}

# VPC Peering Earth to Mars Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "accept" {
  provider                  = aws.useast2
  vpc_peering_connection_id = aws_vpc_peering_connection.earth-mars-peering.id
  auto_accept               = true

  tags = {
    Side = "Mars Peering Accepter"
  }
}
