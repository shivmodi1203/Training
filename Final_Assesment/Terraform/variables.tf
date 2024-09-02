variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "The list of public subnets CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "The list of private subnets CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "The list of availability zones"
  type        = list(string)
}

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

variable "ec2_name" {
  type = list(string)
}

variable "name" {
  description = "The name prefix for resources"
  type        = string
  default     = "sp"
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "container_port" {
  description = "The port on which the container is running"
  type        = number
  default     = 80
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "mynew_Cluster"
}

variable "task_family_name" {
  description = "The name of the ECS task family"
  type        = string
  default     = "mynew_Cluster"
}

variable "container_image" {
  description = "The Docker image to be used"
  type        = string
  default     = "Sp_Image"

}

variable "container_environment" {
  description = "The environment variables for the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "ENVIRONMENT"
      value = "Dev"
    }
  ]
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "my_ECS"
}

# variable "db_name" {
#   description = "The name of the database"
#   type        = string
#   default = "sp-ecs-db"
# }

# variable "db_username" {
#   description = "The username for the database"
#   type        = string
#   default = "admin"
# }

# variable "db_password" {
#   description = "The password for the database"
#   type        = string
#   default = "MySecurePassword123!"
# }
