
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block
  azs                  = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  private_subnet_names = var.private_subnet_names
  public_subnet_names  = var.public_subnet_names
  manage_default_network_acl = true
  manage_default_route_table = false
  manage_default_security_group = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway = true
  single_nat_gateway = true
  create_igw         = true
  enable_vpn_gateway = false
}
