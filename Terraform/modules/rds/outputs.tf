output "endpoint_rds" {
  value = aws_db_instance.ghost_db_instance.endpoint
}