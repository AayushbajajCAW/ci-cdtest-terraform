# variable "AWS_ACCESS_KEY_ID" {
  
# }
# variable "AWS_SECRET_ACCESS_KEY" {
  
# }
## VPC Variables ##
variable "vpc_cidr_block" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "private_subnet_names" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "public_subnet_names" {
  type = list(string)
}
variable "database_subnet_names" {
}
variable "api_private_subnet_names" {
}
## S3 Variables ##
variable "s3_bucket_names" {
  type = set(string)
}
## Security Group Variables ##
variable "security_group_names" {
  type=list(string)
}
variable "config" {}

## ECR variables ##
variable "ecr_repo_fields" {
  type = map(any)
}

## RDS Variables ##
variable "rds_name" {
  type = string

}
variable "rds_engine" {
  type = string

}
variable "rds_engine_version" {
  type = string

}
variable "rds_engine_family" {
  type = string
}
variable "rds_major_engine_version" {
  type = string
}
variable "rds_instance_class" {
  type = string
}
variable "rds_allocated_storage" {
  type = number
}
variable "rds_max_allocated_storage" {
  type = number
}
variable "rds_db_name" {
  type = string
}
variable "rds_db_username" {
  type = string
}
variable "rds_db_port" {
  type = number
}

## Application Load Balancer variables ##
variable "alb_name" {
  type = string
}
variable "alb_load_balancer_type" {
  type = string
}
variable "target_groups" {
  type = map(any)
}
variable "alb_http_tcp_listeners" {
  type = map(any)
}

##ECS Variables ##
variable "ecs_cluster_name" {
  type = string
}
variable "param_names" {
  type = map(any)
}

##Task Defination variables ##
variable "td_container_name" {
  type = string
}


variable "ecs_service_name" {
 
}


variable "ecs_as_cpu_low_threshold_per" {
  default = "20"
}
variable "ecs_as_cpu_high_threshold_per" {
  default = "80"
}

variable "cache_policy_name" {
  type = string
}

variable "cache_policy_name_cloudfront" {
  type = string
}


