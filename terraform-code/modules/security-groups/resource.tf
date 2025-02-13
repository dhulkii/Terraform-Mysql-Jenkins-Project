
resource "aws_security_group" "dev_SG" {
  name   = "dev-SG"
  vpc_id = var.dev_vpc

  tags = {
    Name = "dev-security-group"
  }
}

# Allow SSH (22) from anywhere
resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.dev_SG.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow HTTP (80) from anywhere
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.dev_SG.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow HTTPS (443) from anywhere
resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.dev_SG.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow PostgreSQL from private SG (after both SGs are created)
resource "aws_security_group_rule" "allow_postgres_from_private" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.dev_SG.id
  source_security_group_id = var.private_SG_id
  depends_on               = [aws_security_group.dev_SG]
}

# Allow all outgoing traffic
resource "aws_security_group_rule" "dev_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.dev_SG.id
  cidr_blocks       = ["0.0.0.0/0"]
}
