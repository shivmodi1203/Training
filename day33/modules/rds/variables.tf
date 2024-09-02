variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "Sp_DB"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}


variable "private_subnets" {
  description = "The private subnets to use"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"] 
}

variable "db_subnet_group_name" {
  type        = string
  default     = "my_subnet_group"
}
variable "availability_zones" {
  description = "The list of availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}