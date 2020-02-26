resource "aws_api_gateway_rest_api" "ag" {
  name        = "Jodi API Gateway"
  description = "A REST API Gateway to be used with Lambda"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "example_api_resource" {
  rest_api_id = aws_api_gateway_rest_api.ag.id
  parent_id = aws_api_gateway_rest_api.ag.root_resource_id
  path_part = "messages"
}

resource "aws_api_gateway_method" "example_api_method" {
  rest_api_id = aws_api_gateway_rest_api.ag.id
  resource_id = aws_api_gateway_resource.example_api_resource.id
  http_method = "GET"
  authorization = "NONE"
}

#This MOCK stuff is just temporary for testing that it is working before I make the Lambda
resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id          = aws_api_gateway_rest_api.ag.id
  resource_id          = aws_api_gateway_resource.example_api_resource.id
  http_method          = aws_api_gateway_method.example_api_method.http_method
  type                 = "MOCK"

  request_templates = {
     "application/json" =  <<EOF
      {
       "statusCode" : 200
      }
      EOF
  }
}

resource "aws_api_gateway_deployment" "beta_deployment" {
  depends_on = [aws_api_gateway_integration.MyDemoIntegration]

  rest_api_id = aws_api_gateway_rest_api.ag.id
  stage_name  = "beta"
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.ag.id
  resource_id = aws_api_gateway_resource.example_api_resource.id
  http_method = aws_api_gateway_method.example_api_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.ag.id
  resource_id = aws_api_gateway_resource.example_api_resource.id
  http_method = aws_api_gateway_method.example_api_method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
}

output "invoke_url" {
  value = aws_api_gateway_deployment.beta_deployment.invoke_url
  description = "The invoke url for the beta stage" 
}

output "stage_name" {
  value = aws_api_gateway_deployment.beta_deployment.stage_name
  description = "The name of the stage" 
}

