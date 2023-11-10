provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "intro" {
  ami                    = "ami-0dbc3d7bc646e8516"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "terra-key"
  vpc_security_group_ids = ["sg-07ce6b825dcd0a236"]
  tags = {
    Name    = "Terra-Instance"
    Project = "Terra"
  }
}