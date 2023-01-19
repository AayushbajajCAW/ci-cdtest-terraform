data "aws_subnets" "api_public_subnets" {
  filter {
    name   = "tag:Name"
    values = [var.database_subnet_names[0],var.database_subnet_names[1]]
  }
  depends_on = [
    module.vpc
  ]
}
data "aws_subnets" "api_private_subnets" {
  filter {
    name   = "tag:Name"
    values = [var.api_private_subnet_names[0],var.api_private_subnet_names[1]]
  }
  depends_on = [
    module.vpc
  ]
}

data "aws_security_group" "backend-api-link-sg" {
  name = var.security_group_names[1]
  depends_on = [
    aws_security_group.this-sg
  ]
}
data "aws_security_group" "backend-load-balancer-sg" {
  name = var.security_group_names[2]
  depends_on = [
    aws_security_group.this-sg
  ]
}

data "aws_canonical_user_id" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy" "ecs-policy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}
data "aws_iam_policy" "esc-autoscale-policy" {
  name = "AmazonEC2ContainerServiceAutoscaleRole"
}
data "aws_s3_bucket" "bucket_one" {
  bucket = "bucket1testaayush.app"
  depends_on = [
    aws_s3_bucket.this
  ]
}
data "aws_cloudfront_cache_policy" "cache_policy_cloudfront" {
    name = var.cache_policy_name_cloudfront
}