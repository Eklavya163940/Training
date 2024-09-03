variable "subnet_id" {
  description = "The subnet ID for the EC2 instance"
  type        = string
}


variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The key pair name for SSH access"
  type        = string
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
}

variable "security_groups" {
  description = "A list of security group IDs"
  type        = list(string)
}
