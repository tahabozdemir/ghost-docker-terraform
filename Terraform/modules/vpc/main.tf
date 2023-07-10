resource "aws_vpc" "ghost_vpc" {
  cidr_block           = var.ghost_vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Ghost VPC"
  }
}

resource "aws_internet_gateway" "ghost_igw" {
  vpc_id = aws_vpc.ghost_vpc.id

  tags = {
    Name = "Ghost Internet Gateway"
  }
}

resource "aws_route_table" "ghost_rt_public" {
  vpc_id = aws_vpc.ghost_vpc.id

  tags = {
    Name = "Ghost Public Route Table"
  }
}

resource "aws_route_table" "ghost_rt_private" {
  vpc_id = aws_vpc.ghost_vpc.id

  tags = {
    Name = "Ghost Private Route Table"
  }
}

resource "aws_route" "ghost_route_public" {
  route_table_id         = aws_route_table.ghost_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ghost_igw.id
}

resource "aws_subnet" "ghost_subnet_public" {
  vpc_id            = aws_vpc.ghost_vpc.id
  cidr_block        = var.ghost_subnet_public_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Ghost Public Subnet eu-west-1a"
  }
}
#Private subnets have to be in different zones for RDS
resource "aws_subnet" "ghost_subnet_private" {
  vpc_id            = aws_vpc.ghost_vpc.id
  cidr_block        = var.ghost_subnet_private_cidrs[0]
  availability_zone = var.ghost_subnet_availability_zones[0]

  tags = {
    Name = "Ghost Private Subnet eu-west-1a"
  }
}

resource "aws_subnet" "ghost_subnet_private2" {
  vpc_id            = aws_vpc.ghost_vpc.id
  cidr_block        = var.ghost_subnet_private_cidrs[1]
  availability_zone = var.ghost_subnet_availability_zones[1]

  tags = {
    Name = "Ghost Private Subnet eu-west-1b"
  }
}

resource "aws_route_table_association" "ghost_subnet_association_public" {
  subnet_id      = aws_subnet.ghost_subnet_public.id
  route_table_id = aws_route_table.ghost_rt_public.id
}

resource "aws_route_table_association" "ghost_subnet_association_private" {
  subnet_id      = aws_subnet.ghost_subnet_private.id
  route_table_id = aws_route_table.ghost_rt_private.id
}

