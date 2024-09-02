# S3 Bucket
resource "aws_s3_bucket" "test_bucket" {
  bucket = "eklavya-bucket-${terraform.workspace}"
  tags = {
    Name = "app_s3_bucket_${terraform.workspace}"
  }
}