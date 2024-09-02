provider "aws" {
  region  = "ap-southeast-1"
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.cidr
  availability_zone = var.availability_zones
  public_cidr_block = var.public_subnets
  private_cidr_block = var.private_subnets
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  security_group_ids = [module.security_group.id]
  public_subnet_id = module.vpc.public_subnet_id[0]
  ec2_name = var.ec2_name
  ec2_instance_type = var.ec2_instance_type
}