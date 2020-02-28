#TODO - could replace this with something like this: https://github.com/infrablocks/terraform-aws-base-networking/blob/master/private_subnets.tf
resource "aws_subnet" "public_subnet_one" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_one_cidr
    availability_zone = var.aws_availability_zone_one
   
    tags = {
      Name = "Public Subnet One"
    }
}

resource "aws_subnet" "public_subnet_two" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_two_cidr
    availability_zone = var.aws_availability_zone_two
   
    tags = {
      Name = "Public Subnet Two"
    }
}

resource "aws_subnet" "private_subnet_one" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_one_cidr
    availability_zone = var.aws_availability_zone_one
   
    tags = {
      Name = "Private Subnet One"
    }
}

resource "aws_subnet" "private_subnet_two" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_two_cidr
    availability_zone = var.aws_availability_zone_two
   
    tags = {
      Name = "Private Subnet Two"
    }
}

resource "aws_db_subnet_group" "private_subnet_group" {
  name       = "rds_subnets"
  subnet_ids = [aws_subnet.private_subnet_one.id,aws_subnet.private_subnet_two.id]
}
