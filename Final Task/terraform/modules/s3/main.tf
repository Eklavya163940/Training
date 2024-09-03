resource "aws_s3_bucket" "test_bucket" {
  bucket = "eklavya-s3-bucket-${terraform.workspace}"
  tags = {
    Name = "app_s3_bucket_${terraform.workspace}"
  }
}



output "bucket_name" {
  value = aws_s3_bucket.test_bucket.bucket
}
