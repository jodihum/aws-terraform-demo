locals {
  all_ips = "0.0.0.0/0"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.vpc.id
}

# NOTE I am using default ACLs and Security Groups. If there are problems - look here. 


