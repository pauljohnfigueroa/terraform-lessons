# OUTPUT
output "server_private_ip" {
  value = aws_instance.ubuntu.private_ip
}

output "server_public_ip" {
  value = aws_instance.ubuntu.public_ip
}

output "server_id" {
  value = aws_instance.ubuntu.id
}

# 2nd EC2 instance
output "server2_private_ip" {
  value = aws_instance.ubuntu2.private_ip
}

output "server2_public_ip" {
  value = aws_instance.ubuntu2.public_ip
}

output "server2_id" {
  value = aws_instance.ubuntu2.id
}