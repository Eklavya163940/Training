provider "aws" {
  region = "ap-southeast-1"
}

module "ec2_instance_master" {
  source         = "./modules/ec2"
  ami_id          = "ami-05b6bf467f8c84d53"
  instance_type  = "t2.medium"
  key_name        = "eklavya-day35"
  instance_name  = "eklavya-k8s-master"
  security_groups = ["sg-06f4ab19972912b2d"]
  subnet_id       = "subnet-0907443228156eee5"  # Replace with your subnet ID
}

module "ec2_instance_worker" {
  source         = "./modules/ec2"
  ami_id          = "ami-05b6bf467f8c84d53"
  instance_type  = "t2.micro"
  key_name        = "eklavya-day35"
  instance_name  = "eklaya-k8s-worker"
  security_groups = ["sg-06f4ab19972912b2d"]
  subnet_id       = "subnet-0907443228156eee5"  # Replace with your subnet ID
  count          = 1
}

module "s3_bucket" {
  source = "./modules/s3"  # Path to your S3 module

  bucket_prefix = "eklavya-s3-bucket"
  tags = {
    Name = "app_s3_bucket_${terraform.workspace}"
  }


  static_files = [
    {
      key    = "panda.jpeg"
      source = "/home/einfochips/Downloads/Final Task/terraform/panda.jpeg"
    },
    
  ]

  # Enable public read access
  enable_public_read = true
}

output "master_instance_id" {
  value = module.ec2_instance_master.instance_id
}

output "worker_instance_ids" {
  value = module.ec2_instance_worker[*].instance_id
}

output "s3_bucket_name" {
  value = module.s3_bucket.bucket_name
}
