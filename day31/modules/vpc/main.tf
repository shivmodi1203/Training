# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc-${terraform.workspace}"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  count = length(var.public_cidr_block)
  vpc_id            = aws_vpc.main.id
  cidr_block        = "${var.public_cidr_block[count.index]}"
  map_public_ip_on_launch = true
  availability_zone = "${var.availability_zone[count.index]}"
  tags = {
    Name = "public-subnet-${terraform.workspace}"
  }
}

# Define the Private Subnet
resource "aws_subnet" "private" {
  count = length(var.private_cidr_block)
  vpc_id            = aws_vpc.main.id
  cidr_block        = "${var.private_cidr_block[count.index]}"
  availability_zone = "${var.availability_zone[count.index]}"
  tags = {
    Name = "private-subnet-${terraform.workspace}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw-${terraform.workspace}"
  }
}

# Define the Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "my-public-route-table"
  }
}

# Define the Route Table Association for Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id[0]
  route_table_id = aws_route_table.public.id
}