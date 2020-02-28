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


module "rds" {
  source = "../modules/rds"

  subnet_group_name = module.vpc.subnet_group_name
  private_network_cidr = module.vpc.vpc_cidr
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}


module "cloud-front" {
  source = "../modules/cloud-front"
}



