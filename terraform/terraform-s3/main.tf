module "s3_bucket" {
  source         = "./modules/S3"
  s3_bucket_name = var.s3_bucket_name
}

module "dynamodb_table" {
  source = "./modules/dynamodb_table"
}