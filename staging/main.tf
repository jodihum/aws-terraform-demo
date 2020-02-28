terraform {
  required_providers {
    aws = "~> 2.50"
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "../modules/vpc"
}

/*
module "rds" {
  source = "../modules/rds"

  subnet_group_name = module.vpc.subnet_group_name
}
*/

module "cloud-front" {
  source = "../modules/cloud-front"
}



