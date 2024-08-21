variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default = "ami-000a81e3bab21747d"
  type        = string
}

variable "ec2_instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "subnet id"
}