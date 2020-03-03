resource "aws_lambda_function" "hello_world" {
   function_name = "hello_world_function"
   filename =  "${path.module}/lambdatest.zip"

   handler = "index.handler"
   runtime = "nodejs12.x"

   role = aws_iam_role.lambda_role.arn

   vpc_config  {
      subnet_ids = var.private_subnet_ids
      security_group_ids = [aws_security_group.lambda_security_group.id]
   }

  environment {
    variables = {
      RDS_HOSTNAME = var.hostname
      RDS_USERNAME = var.username
      RDS_PASSWORD = var.password
      RDS_PORT     = var.rds_port
      RDS_DATABASE = var.database
    }
  }

}


