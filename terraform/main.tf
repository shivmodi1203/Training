module "s3_bucket" {
  source         = "./modules/S3"
  s3_bucket_name = var.s3_bucket_name
}

module "vpc" {
  source = "./modules/vpc"
}

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