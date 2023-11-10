variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1      = "ami-0dbc3d7bc646e8516"
    ap-southeast-1 = "ami-06018068a18569ff2"
    ap-southeast-2 = "ami-09b402d0a0d6b112b"
  }
}

variable "MYIP" {
  default = "49.150.102.46/32"
}

variable "USER" {
  default = "ec2-user"
}

variable "PRIV_KEY" {
  default = "terra"
}
variable "PUB_KEY" {
  default = "terra.pub"
}