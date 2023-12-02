variable "vpc_id" {
  type = string
  description = "VPC Id"
}

variable "cidr_block" {
  type = string
  description = "Subnet CIDR Block"
}

variable "webserver_name" {
  type = string
  description = "Name of the Webserver"
}

variable "ami" {
  type = string
  description = "AMI to use on the webserver instance"
}

variable "instance_type" {
  type = string
  description = "Instance Type"
  default = "t2.micro"
}