# EC2 instance in the public subnet

resource "aws_instance" "dev_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  vpc_security_group_ids      = var.security_group_ids
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true


  tags = {
    Name = "application-ec2"
  }
}


