output "invoke_arn" {
  value  = aws_lambda_function.hello_world.invoke_arn
  description = "The arn for the above lambda function"
}

output "security_group_id" {
  value  = aws_security_group.lambda_security_group.id
  description = "The ID of the security group"
}
