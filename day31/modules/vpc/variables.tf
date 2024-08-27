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
