module "s3_bucket" {
  source         = "./modules/S3"
  s3_bucket_name = var.s3_bucket_name
}

module "vpc" {
  source = "./modules/vpc"
}

# module "security_groups" {
#   source = "./modules/security_group"
#   vpc_id = module.vpc.vpc_id
# }

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  cidr_block = var.cidr_block
  availability_zone = var.availability_zone
}

module "EC2" {
  source = "./modules/ec2"
  subnet_id = module.subnet.subnet_id[0]
}

# module "db_instance" {
#   source = "./modules/db_instance"
#   subnet_ids = [module.subnet.subnet_id[0],module.subnet.subnet_id[1]]
#   rds_instance_type = var.rds_instance_type
#   db_username = var.db_username
#   db_password = var.db_password
# } 