# creation of vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "dev-vpc"
  }
}

# creation of public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "dev-public-subnet"
  }
}

# creation of private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "dev-private-subnet"
  }
}

# creation of Internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "dev-IGW"
  }
}

# Creation of Elastic IP for NAT Gateway
resource "aws_eip" "elastic-ip" {
  domain = "vpc"
}

# creation of NatGateway
resource "aws_nat_gateway" "NAT" {
  subnet_id     = aws_subnet.public-subnet.id
  allocation_id = aws_eip.elastic-ip.id
  depends_on    = [aws_eip.elastic-ip]
  tags = {
    Name = "dev-NAT"
  }
}

# creation of public route table
resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "dev-public-RT"
  }
}

# creation of public route table association
resource "aws_route_table_association" "public-RT-Asso" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-RT.id
}

# creation of private route table
resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "dev-private-RT"
  }
}

# creation of private route table association
resource "aws_route_table_association" "private-RT-Asso" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-RT.id
}

# public Route to Internet Gateway for Internet Access
resource "aws_route" "IGW-route" {
  route_table_id         = aws_route_table.public-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
  depends_on             = [aws_internet_gateway.IGW]
}

# Private Route to NAT Gateway for Internet Access
resource "aws_route" "NAT-route" {
  route_table_id         = aws_route_table.private-RT.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NAT.id
  depends_on             = [aws_nat_gateway.NAT]
}

