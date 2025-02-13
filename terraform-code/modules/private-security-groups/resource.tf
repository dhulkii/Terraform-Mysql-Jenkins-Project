
resource "aws_security_group" "private_SG" {
  name   = "private-SG"
  vpc_id = var.dev_vpc

  tags = {
    Name = "private-security-group"
  }
}

# Allow SSH from public EC2 SG (after both SGs are created)
resource "aws_security_group_rule" "allow_ssh_from_public_ec2" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_SG.id
  source_security_group_id = var.dev_SG_id
  depends_on               = [aws_security_group.private_SG]
}

# Allow PostgreSQL from public EC2 SG
resource "aws_security_group_rule" "allow_postgres_from_public_ec2" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_SG.id
  source_security_group_id = var.dev_SG_id
  depends_on               = [aws_security_group.private_SG]
}

# Allow outgoing PostgreSQL traffic
resource "aws_security_group_rule" "private_sg_egress" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.private_SG.id
  #source_security_group_id = var.dev_SG_id
  cidr_blocks              = ["0.0.0.0/0"]
  #depends_on              = [aws_security_group.private_SG]
}
