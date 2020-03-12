locals {
  lambda_name = "database-schema-lambda"
  common_tags = {
    project      = var.project
    module       = "lambda"       
    Owner        = var.owner
  }
}

/*
  Lambda for use with API Gateway
*/

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

  tags = local.common_tags

}

resource "aws_lambda_permission" "from_api_gateway" {
    statement_id  = "AllowAPIGatewayInvoke"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.hello_world.function_name
    principal     = "apigateway.amazonaws.com"

    source_arn = "${var.api_gateway_deployment_execution_arn}/*/*"
}

/*
  Lambda for setting up database schema
*/

resource "aws_lambda_function" "setup_database_schema" {
   function_name = "setup_database_schema"
   filename =  "${path.module}/schema_lambda.zip"

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

  tags = local.common_tags

}

