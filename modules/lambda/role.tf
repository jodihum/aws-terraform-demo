#TODO - give lambda access to RDS
#IAM role which dictates what other AWS services the Lambda function may access
resource "aws_iam_role" "lambda_role" {
   name = "LambdaRDSRole"

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

}

resource "aws_lambda_permission" "apigw" {
    statement_id  = "AllowAPIGatewayInvoke"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.hello_world.function_name
    principal     = "apigateway.amazonaws.com"

#    source_arn = "${var.api_gateway_deployment_execution_arn}/*/*"
}

resource "aws_iam_role_policy_attachment" "lambda_attachment_vpc_exec" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}


/*
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_retention
}
*/



