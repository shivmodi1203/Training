resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
}

resource "aws_db_subnet_group" "main" {
  name       = var.db_subnet_group_name
  subnet_ids = [aws_subnet.private[0],aws_subnet.private[1]]

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot  = true

  tags = {
    Name = "MyRDSInstance"
  }
}