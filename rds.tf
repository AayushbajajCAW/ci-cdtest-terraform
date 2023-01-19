module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.rds_name
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  family               = var.rds_engine_family
  major_engine_version = var.rds_major_engine_version
  instance_class       = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  db_name  = var.rds_db_name
  username = var.rds_db_username
  port     = var.rds_db_port
  multi_az               = false
  create_db_subnet_group = true
  subnet_ids             = data.aws_subnets.api_public_subnets.ids
  vpc_security_group_ids = [module.db-sg.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_cloudwatch_log_group     = false

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "example-monitoring-role-name"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "Description for monitoring role"

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  depends_on = [
    aws_security_group.this-sg,
    module.vpc
  ]
}

resource "aws_budgets_budget" "rds-budget" {
  name              = "budget-rds-daily"
  budget_type       = "COST"
  limit_amount      = "5"
  limit_unit        = "USD"
  time_unit         = "DAILY"

  cost_filter {
    name = "Service"
    values = [
      "Amazon Relational Database Service",
    ]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["aayush.bajaj@cawstudios.com"]
  }
}