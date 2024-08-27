module "S3" {
  source = "./modules/S3"
}

module "vpc" {
  source = "./modules/vpc"
  availability_zone = var.availability_zone
  private_cidr_block = var.private_cidr_block
  public_cidr_block = var.public_cidr_block
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "IAM" {
  source = "./modules/IAM"
}

module "EC2" {
  source = "./modules/ec2"
  security_group_ids = [module.security_group.id]
  public_subnet_id = module.vpc.public_subnet_id[0]
  iam_instance_profile = module.IAM.instance_profile_name
}