terraform {
  required_providers {
    aws = "~> 2.50"
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "../../modules/services/vpc"
}

module "rds" {
  source = "../../modules/services/rds"

  subnet_group_name = module.vpc.subnet_group_name
}


module "cloud-front" {
  source = "../../modules/services/cloud-front"
}

output "test_output" {
  value = "TEST OUTPUT"
  description = "For testing outputs"
}


