output "dev_vpc" {
  value = module.vpc.dev_vpc_output
}

output "dev_SG_id" {
  value = module.security_groups.dev_SG_id
}

output "private_SG_id" {
  value = module.private_security_groups.private_SG_id # Correct reference
}

output "dev_ec2" {
  value = module.ec2.dev_ec2
}

output "public_instance_ip" {
  value = module.ec2.public_instance_ip
}

output "private_instance_ip" {
  value = module.ec2_private.private_instance_ip
}


