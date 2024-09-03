output "instance_id2" {
  value = aws_instance.this[*].id
}
