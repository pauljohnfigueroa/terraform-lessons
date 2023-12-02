provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "PaulVpc"
  }
}

module "my_webserver" {
  source = "../modules/webserver"

  # pass variables to the module
  vpc_id         = aws_vpc.main.id
  cidr_block     = "10.0.1.0/24" # subnet CIDR
  webserver_name = "PaulWebserver"
  ami            = "ami-0230bd60aa48260c6" # ami-0230bd60aa48260c6 us-east-1 amazon linux 2023
  # instance_type = "" # defaults to t2.micro as configured in the variables.tf 
}

# output "instance_data" {
#   value = module.my_webserver.instance
# }