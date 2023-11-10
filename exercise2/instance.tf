resource "aws_instance" "terra-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "terra-key"
  vpc_security_group_ids = ["sg-07ce6b825dcd0a236"]
  tags = {
    Name    = "Terra-Instance"
    Project = "Terra"
  }
}