variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default = "ami-085f9c64a9b75eed5"
  type        = string
}

variable "ec2_instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  default = "shiv-key-terraform-stagging"
}

variable "security_group_ids" {
  type        = list(string)
}

variable "iam_instance_profile" {
  
}

variable "public_subnet_id" {
  
}