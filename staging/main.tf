locals {
  project = "Jodi Test"
  owner = "Jodi"
  region = "us-east-2"
  should_encrypt_rds = "no"
}

terraform {
  required_providers {
    aws = "~> 2.50"
  }
}

provider "aws" {
  region = local.region
}

module "vpc" {
  source = "../modules/vpc"

  aws_region = local.region
  aws_availability_zone_one = "${local.region}a"
  aws_availability_zone_two = "${local.region}b"
  
  project = local.project 
  owner = local.owner
}

module "lambda" {
  source = "../modules/lambda"

  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
  api_gateway_deployment_execution_arn = module.api_gateway.deployment_execution_arn
  hostname = module.rds.hostname
  username = module.rds.database_master_user
  password = module.rds.database_master_user_password
  database = module.rds.database_name
  rds_port = module.rds.database_port
  role_name = "LambdaRDSRole-${module.vpc.vpc_id}"
  sns_topic = module.rds.sns_topic_arn

  project = local.project
  owner = local.owner
}

module "rds" {
  source = "../modules/rds"

  subnet_group_name = module.vpc.subnet_group_name
  lambda_security_group = module.lambda.security_group_id
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  database_instance_class = local.should_encrypt_rds == "yes" ? "db.m4.large" : "db.t2.micro" 
  should_encrypt = local.should_encrypt_rds

  project = local.project
  owner = local.owner
}

module "api_gateway" {
  source = "../modules/api-gateway"

  lambda_invoke_arn = module.lambda.invoke_arn

  project = local.project
  owner = local.owner
}

module "cloud-front" {
  source = "../modules/cloud-front"
 
  api_gateway_invoke_url = module.api_gateway.invoke_url
  api_gateway_stage_name = module.api_gateway.stage_name

  project = local.project
  owner = local.owner
}


output "cloud_front_domain_name" {
  value = module.cloud-front.domain_name
  description = "The domain name for the cloud front"
}
 
output "database_master_password" {
  value = module.rds.database_master_user_password
  description = "The master password for the rds database.  This is being output because the default is to randomly generate it."
}
