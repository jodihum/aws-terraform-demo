output "subnet_group_name" {
  value = aws_db_subnet_group.private_subnet_group.name
  description = "The group of private subnets that will be used for Multi AZ RDS"
}
