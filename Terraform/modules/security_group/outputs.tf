output "sg_web_id" {
  value = aws_security_group.ghost_sg_web.id
}

output "sg_db_id" {
  value = aws_security_group.ghost_sg_db.id
}