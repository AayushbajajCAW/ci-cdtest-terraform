module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name               = var.alb_name
  internal           = true
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = data.aws_subnets.api_public_subnets.ids
  security_groups = [data.aws_security_group.backend-api-link-sg.id]

  target_groups = [
    {
      name             = var.target_groups["name"]
      backend_protocol = var.target_groups["backend_protocol"]
      backend_port     = var.target_groups["backend_port"]
      target_type      = var.target_groups["target_type"]
    }
  ]

  http_tcp_listeners = [
    {
      port               = var.alb_http_tcp_listeners["port"]
      protocol           = var.alb_http_tcp_listeners["protocol"]
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
  depends_on = [
    module.vpc,
    aws_security_group.this-sg
  ]
}