# S3 Bucket
resource "aws_s3_bucket" "test_bucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name = "app_s3_bucket"
  }
}