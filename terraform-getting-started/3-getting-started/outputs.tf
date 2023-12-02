output "instance_public_ip" {
  value       = aws_instance.foobar.public_ip
  description = "The instance's public IP address."
}

output "vpc_data" {
  value       = aws_vpc.main
  description = "VPC Information."
}