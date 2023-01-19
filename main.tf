terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.44.0"
    }
  }
}

provider "aws" {
  region     = var.region_aws
  access_key = "AKIAZKRR5PF6XFE5C4G2"
  secret_key = "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"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs             = [var.subnet_zones]
  public_subnets  = [var.web_subnets]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "ssh_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "ssh-server"
  description = "Security group for web-server with sshports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = var.image_name
  instance_type          = var.server_type
  key_name               = var.public_key
  # monitoring             = true
  vpc_security_group_ids = [module.ssh_server_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}