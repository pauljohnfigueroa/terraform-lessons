/*  
Default values. May be overriden in other files
*/

# VPC 
region     = "us-east-1"
cidr_block = "10.0.0.0/16"
vpc_name   = "Main VPC"

# Subnets
pub_subnet_name = "Public Subnet (default name)"
pub_subnet_az   = "us-east-1a"
pub_subnet_cidr = "10.0.1.0/24"

priv_subnets = {
  "pub-subnet-1" = {
    name = "Private Subnet 1"
    az   = "us-east-1b"
    cidr = "10.0.1.0/24"
  },

  "pub-subnet-2" = {
    name = "Private Subnet 2"
    az   = "us-east-1c"
    cidr = "10.0.2.0/24"
  },
  "pub-subnet-3" = {
    name = "Private Subnet 3"
    az   = "us-east-1d"
    cidr = "10.0.3.0/24"
  }
}