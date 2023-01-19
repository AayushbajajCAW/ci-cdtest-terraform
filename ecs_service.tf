resource "aws_ecs_service" "this_service" {
  name                               = var.ecs_service_name[0]
  cluster                            = module.ecs.cluster_id
  task_definition                    = aws_ecs_task_definition.test.arn
  desired_count                      = 2
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  launch_type                        = "FARGATE"
  health_check_grace_period_seconds  = 0

  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = var.td_container_name
    container_port   = 80
  }
  network_configuration {
    subnets         =  data.aws_subnets.api_private_subnets.ids
    security_groups = [module.db-sg.security_group_id]
  }
  depends_on = [
    module.alb,
    module.vpc
  ]
}