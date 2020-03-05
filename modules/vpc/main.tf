locals {
  all_ips = "0.0.0.0/0"
  common_tags = {
    project      = var.project  
    module       = "vpc"
    Owner        = var.owner
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(
    local.common_tags,
    map(
      "Name", var.vpc_name
    )
  )
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    map(
      "Name", "Gateway for ${var.vpc_name}"
    )
  )
}



