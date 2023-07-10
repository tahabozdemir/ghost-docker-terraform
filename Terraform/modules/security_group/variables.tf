variable "sg_name_web" {
  type        = string
  description = "Name of the web security group"
  default     = "ghost_sg_web"
}

variable "sg_name_db" {
  type        = string
  description = "Name of the database security group"
  default     = "ghost_sg_database"
}

variable "sg_description_web" {
  type        = string
  description = "Description of the web security group"
  default     = "Allow SSH, HTTP and HTTPS access to servers."
}

variable "sg_description_db" {
  type        = string
  description = "Description of the database security group"
  default     = "Allow MySQL access to servers."
}

variable "allowed_ssh_ip" {
  description = "Allowed IP for SSH access"
  default     = "0.0.0.0/0"
}

variable "allowed_http_ip" {
  description = "Allowed IP for HTTP access"
  default     = "0.0.0.0/0"
}

variable "allowed_https_ip" {
  description = "Allowed IP for HTTPS access"
  default     = "0.0.0.0/0"
}

variable "ghost_vpc_id" {
  type = string
}