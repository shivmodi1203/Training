# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name        = "main-db-subnet-group"
  subnet_ids  = var.subnet_ids
  tags = {
    Name = "main-db-subnet-group"
  }
}

# RDS MySQL DB Instance
resource "aws_db_instance" "db" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = var.rds_instance_type
  username          = var.db_username
  password          = var.db_password
  publicly_accessible = true
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  tags = {
    Name = "db-instance"
  }
}