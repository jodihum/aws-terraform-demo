resource "aws_lambda_function" "hello_world" {
   function_name = "hello_world_function"
   filename =  "${path.module}/helloworld.js.zip"  

   handler = "helloworld.handler"
   runtime = "nodejs12.x"

   role = aws_iam_role.lambda_role.arn
}

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
    function_name = aws_lambda_function.hello_world.arn
    principal     = "apigateway.amazonaws.com"

    # The /*/* portion grants access from any method on any resource
    # within the API Gateway "REST API".
#    source_arn = "${aws_api_gateway_deployment.resource_name_of_deployment.execution_arn}/*/*"
}


output "invoke_arn" {
  value  = aws_lambda_function.hello_world.invoke_arn
  description = "The arn for the above lambda function"
}
