# VPC
variable "region" {
  type        = string
  description = "Region Name"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

# Subnet
variable "pub_subnet_name" {
  type        = string
  description = "Public Subnet Name"
}

variable "pub_subnet_cidr" {
  type        = string
  description = "Public Subnet CIDR"
}

variable "pub_subnet_az" {
  type        = string
  description = "Public Subnet Availabilty zone"
}

variable "priv_subnets" {
  type = map(
    object({
      name = string,
      az   = string,
      cidr = string
    })
  )
}