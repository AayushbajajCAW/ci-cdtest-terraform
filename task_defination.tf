resource "aws_ecs_task_definition" "test" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
  	"cpu": 0,
    "logConfiguration": {
        "logDriver": "awslogs",
        "secretOptions": null,
        "options": {
          "awslogs-group": "/ecs/test",
          "awslogs-region": "ap-south-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
  	"environment": [{
  			"name": "ACCESS_TOKEN_EXPIRES_IN",
  			"value": "60"
  		},
  		{
  			"name": "JWT_EXPIRES_IN",
  			"value": "30d"
  		},
  		{
  			"name": "port",
  			"value": "80"
  		},
  		{
  			"name": "ZOHO_ESIGN_ACCESS_TOKEN",
  			"value": ""
  		}
  	],
  	"secrets": [{
  		"valueFrom": "arn:aws:ssm:ap-south-1:${data.aws_caller_identity.current.account_id}:parameter/api-access-token-secret-dev",
  		"name": "ACCESS_TOKEN_SECRET"
  	}],
  	"essential": true,
  	"image": "jenkins",
  	"memory": 128,
  	"name": "${var.td_container_name}",
  	"portMappings": [{
  		"hostPort": 80,
  		"protocol": "tcp",
  		"containerPort": 80
  	}],
  	"resourceRequirements":null
  }
]
TASK_DEFINITION


  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = null

  }

  task_role_arn      = aws_iam_role.this_role.arn
  execution_role_arn = aws_iam_role.this_role.arn
  depends_on = [
    aws_iam_role.this_role,
    module.vpc,
    module.alb,
    aws_ecr_repository.this_repository,
    aws_ssm_parameter.this_param
  ]
}

