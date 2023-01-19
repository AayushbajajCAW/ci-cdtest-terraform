
# resource "aws_appautoscaling_target" "ecs_target" {
#   max_capacity       = 2
#   min_capacity       = 1
#   resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
#   role_arn           = aws_iam_role.ecs-autoscale-role.arn
#   depends_on = [
#     aws_ecs_service.this_service
#   ]
# }
# resource "aws_appautoscaling_policy" "app_up" {
#   name               = "app-scale-up"
#   service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
#   resource_id        = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   step_scaling_policy_configuration {
#     adjustment_type         = "ChangeInCapacity"
#     cooldown                = 60
#     metric_aggregation_type = "Average"
#     step_adjustment {
#       metric_interval_lower_bound = 0
#       scaling_adjustment          = 1
#     }
#   }
#    depends_on = [
#     aws_ecs_service.this_service
#   ]
# }
# resource "aws_appautoscaling_policy" "app_down" {
#   name               = "app-scale-down"
#   service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
#   resource_id        = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   step_scaling_policy_configuration {
#     adjustment_type         = "ChangeInCapacity"
#     cooldown                = 300
#     metric_aggregation_type = "Average"
#     step_adjustment {
#       metric_interval_upper_bound = 0
#       scaling_adjustment          = -1
#     }
#   }
#    depends_on = [
#     aws_ecs_service.this_service
#   ]
# }

# resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
#   alarm_name          = "high cpu util alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = var.ecs_as_cpu_high_threshold_per
#   dimensions = {
#     ClusterName = var.ecs_cluster_name
#     ServiceName = var.ecs_service_name
#   }
#   alarm_actions = [aws_appautoscaling_policy.app_up.arn]
#    depends_on = [
#     aws_ecs_service.this_service
#   ]
# }
# resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
#   alarm_name          = "CPU-Utilization-Low-alarm"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = var.ecs_as_cpu_low_threshold_per
#   dimensions = {
#     ClusterName = var.ecs_cluster_name
#     ServiceName = var.ecs_service_name
#   }
#   alarm_actions = [aws_appautoscaling_policy.app_down.arn]
#    depends_on = [
#     aws_ecs_service.this_service
#   ]
# }



