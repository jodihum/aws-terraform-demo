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

