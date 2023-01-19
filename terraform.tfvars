aws_region = "ap-south-1"

## VPC Variables ##
vpc_name = "hbits-dev-vpc"

vpc_cidr_block = "10.0.0.0/16"

private_subnets = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]

public_subnets = ["10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24", "10.0.11.0/24"]

private_subnet_names = ["api-private-subnet-1a", "api-private-subnet-1b", "lp-private-subnet-1a", "lp-private-subnet-1b", "strapi-private-subnet-1a", "strapi-private-subnet-1b"]

public_subnet_names = ["api-public-subnet-1a", "api-public-subnet-1b", "lp-public-subnet-1a", "lp-public-subnet-1b", "strapi-public-subnet-1a", "strapi-public-subnet-1b"]

database_subnet_names = ["api-public-subnet-1a", "api-public-subnet-1b"]

api_private_subnet_names = ["api-private-subnet-1a", "api-private-subnet-1b"]

## S3 Variables ##
s3_bucket_names = [
  "bucket1testaayush.app",
  "bucket2testaayush.app",
  "bucket3testaayush.app",
]

## Security Group Variables ##
security_group_names=["database-sg","backend-api-vpc-link-sg","backend-load-balancer-sg","backend-ecs-service-sg","frontend-load-balancer-sg","frontend-ecs-service-sg"]

config = {
  # database-sg = {
  #   ports = [
  #     {
  #       from   = 0
  #       to     = 0
  #       protocol= "-1"
  #       source = "0.0.0.0/0"
  #     }
  #   ]
  # }
  backend-api-vpc-link-sg = {
    ports =  null
  }
  backend-load-balancer-sg= {
    ports = null
  }
  backend-ecs-service-sg = {
    ports = [{
      from   = 80
      to     = 80
      protocol="tcp"
      source = "10.0.0.0/16"
    }]
  }
  frontend-load-balancer-sg= {
    ports = [
      {
      from=443
      to=443
      protocol="tcp"
      source="0.0.0.0/0"
    },
    {
      from=80
      to=80
      protocol="tcp"
      source="0.0.0.0/0"
    }
    ]
  }
  frontend-ecs-service-sg={
    ports=[{
      from = 4200
      to=4200
      protocol="tcp"
      source="10.0.0.0/16"
    }]
  }
}
## ECR variables ##
ecr_repo_fields = {
  1 = ["aayushrepo", "MUTABLE", true],
  2 = ["aayushrepo1", "MUTABLE", true],
  3 = ["aayushrepo2", "MUTABLE", true]
}

## RDS Variables ##
rds_name                  = "hbits-test-rds"
rds_engine                = "postgres"
rds_engine_version        = "14"
rds_engine_family         = "postgres14"
rds_major_engine_version  = "14"
rds_instance_class        = "db.t3.micro"
rds_allocated_storage     = 20
rds_max_allocated_storage = 100
rds_db_name               = "testpostgresdb"
rds_db_username           = "testrdsuser"
rds_db_port               = 5432

## Application Load Balancer variables ##

alb_name               = "backend-lb-dev"
alb_load_balancer_type = "application"
target_groups = {
  name             = "backend-lb-tg-dev"
  name_prefix      = "dev"
  backend_protocol = "HTTP"
  backend_port     = 80
  target_type      = "ip"
}
alb_http_tcp_listeners = {
  port     = 80
  protocol = "HTTP"
}

##ECS Variables ##

ecs_cluster_name = "test-cliuster"

ecs_service_name = ["backend-ecs-service","frontend-ecs-service","strapi-ecs-service"]

param_names = {
  1 = ["api-access-token-secret-dev", "SecureString", "Dhawalsharma"]
  2 = ["aayush", "SecureString", "abc"]
}
td_container_name = "test-container-dev"

cache_policy_name_cloudfront = "Managed-CachingOptimized"
cache_policy_name = "Custom-backendPolicy"