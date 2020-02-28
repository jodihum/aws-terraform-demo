variable "aws_region" {
    description = "Region for the VPC"
    default = "eu-west-2"
}

variable "aws_availability_zone_one" {
    description = "Primary AZ"
    default = "eu-west-2a"
}

variable "aws_availability_zone_two" {
    description = "Secondary AZ"
    default = "eu-west-2b"
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


