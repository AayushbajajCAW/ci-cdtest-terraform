resource "aws_apigatewayv2_vpc_link" "this-api-gateway2" {
  name               = "example"
  security_group_ids = [data.aws_security_group.backend-api-link-sg.id]
  subnet_ids         = data.aws_subnets.api_private_subnets.ids
  tags = {
    Usage = "example"
  }
  depends_on = [
    module.vpc
  ]
}
resource "aws_apigatewayv2_api" "this-api-gateway2" {
  name          = "example-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "this-api-gateway-integration" {
  api_id           = aws_apigatewayv2_api.this-api-gateway2.id
  integration_type = "HTTP_PROXY"
  connection_type = "VPC_LINK"
  integration_method = "ANY"
  integration_uri    = module.alb.http_tcp_listener_arns[0]
  connection_id = aws_apigatewayv2_vpc_link.this-api-gateway2.id
}

resource "aws_apigatewayv2_route" "example" {
  api_id    = aws_apigatewayv2_api.this-api-gateway2.id
  route_key = "ANY /{proxy+}" //remove emaple

  target = "integrations/${aws_apigatewayv2_integration.this-api-gateway-integration.id}"
}