resource "aws_security_group" "ghost_sg_web" {
  name        = var.sg_name_web
  description = var.sg_description_web
  vpc_id      = var.ghost_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
    description = "SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_ip]
    description = "HTTP access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_https_ip]
    description = "HTTPS access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ghost_sg_db" {
  name        = var.sg_name_db
  description = var.sg_description_db
  vpc_id      = var.ghost_vpc_id

  ingress {
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.ghost_sg_web.id]
    description     = "Allow MySQL traffic from only the ghost_sg_web"
  }
}