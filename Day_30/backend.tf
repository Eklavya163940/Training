terraform {
  backend "s3" {
    bucket         = "eklavya-backend-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}