resource "aws_iam_role" "lambda_role" {
   name = var.role_name 

   assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {
         "Service": "lambda.amazonaws.com"
       },
       "Effect": "Allow",
       "Sid": ""
     }
   ]
}
 EOF

  tags = local.common_tags

}

resource "aws_lambda_permission" "apigw" {
    statement_id  = "AllowAPIGatewayInvoke"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.hello_world.function_name
    principal     = "apigateway.amazonaws.com"

    source_arn = "${var.api_gateway_deployment_execution_arn}/*/*"
}

resource "aws_iam_role_policy_attachment" "lambda_attachment_vpc_exec" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}




