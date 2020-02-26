terraform {
  required_providers {
    aws = "~> 2.50"
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "api-gateway" {
  source = "../../modules/services/api-gateway"
}

module "cloud-front" {
  source = "../../modules/services/cloud-front"
}

output "test_output" {
  value = "TEST OUTPUT"
  description = "For testing outputs"
}


