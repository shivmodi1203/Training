variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "public_cidr_block" {
  description = "public cidr block"
  type = list(string)
}

variable "availability_zone" {
  description = "availability zone"
  type = list(string)
}

variable "private_cidr_block" {
  description = "private cidr block"
  type = list(string)
}


variable "rds_instance_type" {
  description = "The instance type for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The database username"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

# variable "s3_bucket_name" {
#   description = "The name of the S3 bucket"
#   type        = string
# }

 