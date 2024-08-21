variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

 