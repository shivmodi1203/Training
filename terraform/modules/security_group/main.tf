# Security Groups
resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# # IAM Role and Policy for EC2
# resource "aws_iam_role" "ec2_role" {
#   name = "ec2_s3_access_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
#   name       = "ec2_s3_access_policy_attachment"
#   roles      = [aws_iam_role.ec2_role.name]
#   policy_arn  = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
# }

# resource "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "ec2_instance_profile_already_exist"
#   role = aws_iam_role.ec2_role.name
# }

# # Attach IAM Role to EC2 Instance
# resource "aws_instance" "app1" {
#   ami           = var.ami_id
#   instance_type = var.ec2_instance_type
#   subnet_id     = aws_subnet.public.id
#   associate_public_ip_address = true
#   security_groups = [aws_security_group.ec2_sg.name]
#   iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
#   tags = {
#     Name = "app-instance"
#   }
# }
 