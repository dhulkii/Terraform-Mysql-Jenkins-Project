# Output for EC2 instance ID from the EC2 module
output "dev_ec2_private" {
  value = aws_instance.dev_ec2_private.id
}

output "private_instance_ip" {
  value = aws_instance.dev_ec2_private.private_ip
}

