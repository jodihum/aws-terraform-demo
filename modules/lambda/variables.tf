variable "private_subnet_ids" {
  description = "The IDs of the private subnets to deploy the lambda into."
  type = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC lambda will go in"
}

variable "api_gateway_deployment_execution_arn" {
  description = "execution arn for api-gateway deployment"
}

variable "role_name" {
  description = "Name of Lambda Role - IMPORTANT terraform apply will not work if this role name already exists!!"
  default = "LambdaRDSRole"
}

variable "hostname" {
  description = "The host name for RDS"
}

variable "username" {
  description = "User name for the rds database"
}

variable "password" {
  description = "Password for the rds database"
}

variable "rds_port" {
  description = "RDS port"
  default = 3306
}

variable "database" {
  description = "The name of the database to use"
}

variable "sns_topic" {
  description = "The topic that the database schema lambda is subscribed to"
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

