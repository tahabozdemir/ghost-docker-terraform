output "vpc_subnet_public_id" {
  value = aws_subnet.ghost_subnet_public.id
}

output "vpc_subnet_private_id" {
  value = aws_subnet.ghost_subnet_private.id
}

output "vpc_subnet_private_id2" {
  value = aws_subnet.ghost_subnet_private2.id
}

output "ghost_vpc_id" {
  value = aws_vpc.ghost_vpc.id
}
