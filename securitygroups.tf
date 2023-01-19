
resource "aws_security_group" "this-sg" {
  for_each = var.config
  name     = each.key
  vpc_id = module.vpc.vpc_id
  dynamic "ingress" {
    for_each = each.value.ports[*]
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.source]
    }
  }
}
resource "aws_security_group_rule" "this-vpc-link-sg-rules" {
  security_group_id        = data.aws_security_group.backend-load-balancer-sg.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = data.aws_security_group.backend-api-link-sg.id
  depends_on = [
    aws_security_group.this-sg
  ]
}
resource "aws_security_group_rule" "this-vpc-link-2-sg-rules" {
  security_group_id        = data.aws_security_group.backend-load-balancer-sg.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = data.aws_security_group.backend-api-link-sg.id
  depends_on = [
    aws_security_group.this-sg
  ]
}

module "db-sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = var.security_group_names[0]
  vpc_id      = module.vpc.vpc_id
  ingress_with_self = [ {
    from_port=5432
    to_port=5432
    protocol="tcp"
  } ]
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}