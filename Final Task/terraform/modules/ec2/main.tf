resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  tags = {
    Name = var.instance_name
  }

  vpc_security_group_ids = var.security_groups  # For VPC-based security groups

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y docker.io
                sudo systemctl start docker
                sudo systemctl enable docker
                EOF
}

# Define output for instance IDs
output "instance_id" {
  value = aws_instance.this[*].id
}
