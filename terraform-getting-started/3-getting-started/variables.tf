variable "my_instance_type" {
  type        = string
  description = "The size of the EC2 intance"
}

variable "instance_tags" {
  type = object({
    Name = string
    foo  = number
  })
}

variable "foobar" {
  type        = list(number)
  description = "Numbers list"
}