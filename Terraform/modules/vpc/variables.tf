variable "ghost_vpc_cidr" {
  type    = string
  default = "172.16.0.0/16"
}

variable "ghost_subnet_public_cidr" {
  type    = string
  default = "172.16.1.0/24"
}

variable "ghost_subnet_private_cidrs" {
  type = list(string)
  default = [
    "172.16.100.0/24",
    "172.16.101.0/24"
  ]
}

variable "ghost_subnet_availability_zones" {
  type = list(string)
  default = [
    "eu-west-1a",
    "eu-west-1b"
  ]
}