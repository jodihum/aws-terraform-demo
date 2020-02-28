output "subnet_group_name" {
  value = aws_db_subnet_group.private_subnet_group.name
  description = "The group of private subnets that will be used for Multi AZ RDS"
}

output "vpc_cidr" {
  value = var.vpc_cidr
  description = "The cidr block for the vpc"
}

output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "ID of the VPC"
}

output "private_subnet_ids" {
  value = [aws_subnet.private_subnet_one.id,aws_subnet.private_subnet_two.id]
  description = "IDs of the 2 private subnets in the vpc"
}
