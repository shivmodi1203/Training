# IAM Role and Policy for EC2
resource "aws_iam_role" "ec2_role" {
  name = var.role_name+"-${terraform.workspace}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
  name       = var.policy_attachment_name+"-${terraform.workspace}"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn  = var.policy_arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.instance_profile_name+"-${terraform.workspace}"
  role = aws_iam_role.ec2_role.name
}