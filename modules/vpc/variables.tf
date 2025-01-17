variable "aws_region" {
    description = "Region for the VPC"
}

variable "aws_availability_zone_one" {
    description = "Primary AZ"
}

variable "aws_availability_zone_two" {
    description = "Secondary AZ"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

/*
  Subnets
*/

variable "private_subnet_one_cidr" {
    description = "CIDR for the first Private Subnet"
    default = "10.0.0.0/28"
}

variable "private_subnet_two_cidr" {
    description = "CIDR for the second Private Subnet"
    default = "10.0.0.16/28"
}

variable "public_subnet_one_cidr" {
    description = "CIDR for the first Public Subnet"
    default = "10.0.0.32/28"
}

variable "public_subnet_two_cidr" {
    description = "CIDR for the second Public Subnet"
    default = "10.0.0.48/28"
}

/*
  Nat
*/

variable "nat_instance_type" {
    description = "Instance type to be used for nat gateways"
    default = "t2.micro"
}

/* 
  Tags
*/

variable "owner" {
    description = "The person who created this resource"
}

variable "project" {
    description = "The name of the project using this module and resource"
}

variable "vpc_name" {
    description = "The name to use for the VPC"
    default = "Jodi's VPC"
}
