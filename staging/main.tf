terraform {
  required_providers {
    aws = "~> 2.50"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../modules/vpc"
}

module "lambda" {
  source = "../modules/lambda"

  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
  api_gateway_deployment_execution_arn = module.api_gateway.deployment_execution_arn
  username = module.rds.database_master_user
  password = module.rds.database_master_user_password
  database = module.rds.database_name
  rds_port = module.rds.database_port
}

module "rds" {
  source = "../modules/rds"

  subnet_group_name = module.vpc.subnet_group_name
  lambda_security_group = module.lambda.security_group_id
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "api_gateway" {
  source = "../modules/api-gateway"

  lambda_invoke_arn = module.lambda.invoke_arn
}

module "cloud-front" {
  source = "../modules/cloud-front"
 
  api_gateway_invoke_url = module.api_gateway.invoke_url
  api_gateway_stage_name = module.api_gateway.stage_name
}



