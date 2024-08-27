variable "vpc_id" {
  description = "vpc id"
}

variable "cidr_block" {
  description = "cidr block"
  type = list(string)
}

variable "availability_zone" {
  description = "availability zone"
  type = list(string)
}