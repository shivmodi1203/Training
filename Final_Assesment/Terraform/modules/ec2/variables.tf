variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "The instance type for the EC2 instance"
  type        = list(string)
}

variable "key_name" {
  default = "shiv-key-terraform-test"
}

variable "security_group_ids" {
  type        = list(string)
}

# variable "iam_instance_profile" {
  
# }

variable "public_subnet_id" {
  
}

variable "ec2_name" {
  type = list(string)
}