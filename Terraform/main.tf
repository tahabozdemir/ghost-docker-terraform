module "GhostVPC" {
  source = "./modules/vpc"
}

module "GhostSecurityGroup" {
  source       = "./modules/security_group"
  ghost_vpc_id = module.GhostVPC.ghost_vpc_id
}

module "GhostRDS" {
  source                 = "./modules/rds"
  vpc_subnet_private_id  = module.GhostVPC.vpc_subnet_private_id
  vpc_subnet_private_id2 = module.GhostVPC.vpc_subnet_private_id2
  sg_db_id               = module.GhostSecurityGroup.sg_db_id
}

module "GhostS3" {
  source = "./modules/s3"
}

resource "aws_instance" "ghost_web_server" {
  ami                         = data.aws_ami.AmazonLinux.id
  instance_type               = var.ec2_type
  iam_instance_profile        = module.GhostS3.ghost_iam_profile_id
  associate_public_ip_address = true
  user_data                   = file("${path.module}/scripts/setups_amazon_linux.sh")
  subnet_id                   = module.GhostVPC.vpc_subnet_public_id
  vpc_security_group_ids      = [module.GhostSecurityGroup.sg_web_id]
  tags = {
    Name = "Ghost Web Server"
  }
}