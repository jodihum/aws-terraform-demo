variable "api_gateway_invoke_url" {
  description = "The invoke url for the api gateway"
  type = string
}

variable "api_gateway_stage_name" {
  description = "The stage name for the api gateway"
  type = string
}

// Tags

variable "owner" {
    description = "The person who created this resource"
}

variable "project" {
    description = "The name of the project using this module and resource"
}

variable "distribution_name" {
    description = "The name to use for the distribution"
    default = "Jodi Cloud Front Distribution"
}
