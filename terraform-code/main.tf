terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_groups" {
  source        = "./modules/security-groups"
  dev_vpc       = module.vpc.dev_vpc_output
  private_SG_id = module.private_security_groups.private_SG_id
}

module "private_security_groups" {
  source    = "./modules/private-security-groups"
  dev_vpc   = module.vpc.dev_vpc_output
  dev_SG_id = module.security_groups.dev_SG_id # Pass the public EC2 security group ID

}

module "ec2" {
  source             = "./modules/ec2"
  security_group_ids = [module.security_groups.dev_SG_id]
  ami                = var.ami
  instance_type      = var.instance_type
  key_pair           = var.key_pair
  subnet_id          = module.vpc.public_subnet_id
}

module "ec2_private" {
  source               = "./modules/private-ec2"
  security_group_ids   = [module.private_security_groups.private_SG_id] # Correct reference for private security group
  ami                  = var.ami
  instance_type        = var.instance_type
  key_pair             = var.key_pair
  subnet_id            = module.vpc.private_subnet_id

}


terraform {
  backend "s3" {
    bucket = "statefiles-dev"
    key    = "states/terraform.tfstate"
    region = "us-east-1"
  }
}