# S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name = "app-s3-bucket"
  }
}