variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default = "ami-098f49c6470e6b28a"
  type        = string
}

variable "ec2_instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "rds_instance_type" {
  description = "The instance type for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the database"
  default = "my-db"
  type        = string
}

variable "db_username" {
  description = "The database username"
  default = "eklavya"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
  default = "pass1234"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default = "my-bucket-eklavya"
}

 