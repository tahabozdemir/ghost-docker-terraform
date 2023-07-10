output "DNS" {
  value = aws_instance.ghost_web_server.public_dns
}

output "rds_endpoint" {
  value = module.GhostRDS.endpoint_rds
}
