# Output for EC2 instance ID from the EC2 module
output "dev_ec2" {
  value = aws_instance.dev_ec2.id
}

output "public_instance_ip" {
  value = aws_instance.dev_ec2.public_ip
}

