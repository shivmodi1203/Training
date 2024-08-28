variable "role_name" {
  default = "shiv_ec2_s3_access_role"
}

variable "policy_attachment_name" {
  default = "shiv_ec2_s3_access_policy_attachment"
}

variable "policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

variable "instance_profile_name" {
  default = "shiv_ec2_instance_profile_already_exist"
}