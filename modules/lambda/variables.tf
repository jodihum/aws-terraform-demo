variable "private_subnet_ids" {
  description = "The IDs of the private subnets to deploy the lambda into."
  type = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC lambda will go in"
  type = string
}

variable "api_gateway_deployment_execution_arn" {
  description = "execution arn for api-gateway deployment"
  type = string
}

variable "username" {
  description = "User name for the rds database"
  type = string
}

variable "password" {
  description = "Password for the rds database"
  type = string
}

variable "rds_port" {
  description = "RDS port"
  type = string
  default = 3306
}

variable "database" {
  descriptions = "The name of the database to use"
  type = string
}
