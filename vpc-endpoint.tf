# resource "aws_vpc_endpoint" "ssm_service" {
#   vpc_id            = module.vpc.vpc_id
#   service_name      = com.amazonaws.ap-south-1.ssm
#   vpc_endpoint_type = "Interface"
#   policy = jsonencode(
#     {
# 	"Statement": [
# 		{
# 			"Sid": "SSMCommandsReadOnly",
# 			"Principal": "*",
# 			"Action": [
# 				"ssm:ListCommands",
# 				"ssm:ListCommandInvocations",
# 				"ssm:GetCommandInvocation",
# 				"ssm:GetParameters",
# 				"ssm:GetParameter"
# 			],
# 			"Effect": "Allow",
# 			"Resource": "*"
# 		}
# 	]
# }
#   )
#   subnet_ids          = var.api_private_subnets.ids
#   private_dns_enabled = true
#   depends_on = [
#     module.vpc
#   ]
# }

# resource "aws_vpc_endpoint" "ecr_dkr_service" {
#   vpc_id            = module.vpc.vpc_id
#   service_name      = com.amazonaws.ap-south-1.ecr.dkr
#   vpc_endpoint_type = "Interface"
#   subnet_ids          = var.api_private_subnets.ids
#   private_dns_enabled = true
#   depends_on = [
#     module.vpc
#   ]
# }

# resource "aws_vpc_endpoint" "ecr_api_service" {
#   vpc_id            = module.vpc.vpc_id
#   service_name      = com.amazonaws.ap-south-1.ecr.api
#   vpc_endpoint_type = "Interface"
#   subnet_ids          = var.api_private_subnets.ids
#   private_dns_enabled = true
#   depends_on = [
#     module.vpc
#   ]
# }

# resource "aws_vpc_endpoint" "s3_service_service" {
#   vpc_id            = module.vpc.vpc_id
#   service_name      = com.amazonaws.ap-south-1.ecr.api
#   vpc_endpoint_type = "Gateway"
#   private_dns_enabled = false
#   depends_on = [
#     module.vpc
#   ]
# }

# resource "aws_vpc_endpoint_route_table_association" "s3_gateway_route_table" {
#   vpc_endpoint_id = aws_vpc_endpoint.s3_service_service.id
#   route_table_id = module.vpc.private_route_table_ids[0]
# }