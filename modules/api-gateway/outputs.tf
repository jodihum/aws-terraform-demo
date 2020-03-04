output "deployment_execution_arn" {
  value  = aws_api_gateway_deployment.beta_deployment.execution_arn
  description = "The execution arn for the beta deployment" 
}

output "invoke_url" {
  value = aws_api_gateway_deployment.beta_deployment.invoke_url
  description = "The invoke url for the beta stage."
}

output "stage_name" {
  value = aws_api_gateway_deployment.beta_deployment.stage_name
  description = "The name of the stage."
}
