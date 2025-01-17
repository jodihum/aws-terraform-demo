locals {
  common_tags = {
    project      = var.project
    module       = "api-gateway"
    Owner        = var.owner
  }
}

resource "aws_api_gateway_rest_api" "lambda_gateway" {
  name        = "Lambda API Gateway"
  description = "A REST API Gateway to be used with Lambda"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
 
  tags = local.common_tags
}

resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.lambda_gateway.id
   parent_id   = aws_api_gateway_rest_api.lambda_gateway.root_resource_id
   path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
   rest_api_id   = aws_api_gateway_rest_api.lambda_gateway.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "ANY"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_proxy" {
   rest_api_id = aws_api_gateway_rest_api.lambda_gateway.id
   resource_id = aws_api_gateway_method.proxy.resource_id
   http_method = aws_api_gateway_method.proxy.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = var.lambda_invoke_arn
 }

#For handling an empty path at the root of the API

resource "aws_api_gateway_method" "proxy_root" {
   rest_api_id   = aws_api_gateway_rest_api.lambda_gateway.id
   resource_id   = aws_api_gateway_rest_api.lambda_gateway.root_resource_id
   http_method   = "ANY"
   authorization = "NONE"
 }

 resource "aws_api_gateway_integration" "lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.lambda_gateway.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = var.lambda_invoke_arn
 }


resource "aws_api_gateway_deployment" "beta_deployment" {
   depends_on = [
     aws_api_gateway_integration.lambda_proxy,
     aws_api_gateway_integration.lambda_root,
   ]

   rest_api_id = aws_api_gateway_rest_api.lambda_gateway.id
   stage_name  = "beta"
}

