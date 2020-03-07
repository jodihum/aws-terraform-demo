variable "vpc_id" {
  description = "The ID of the VPC into which to deploy the database."
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets to deploy the database into."
  type = list(string)
}

variable "lambda_security_group" {
  description = "Security group for lambda."
}

variable "subnet_group_name" {
  description = "The name of the group of private subnets"
}

variable "allocated_storage" {
  description = "The allocated storage in GBs."
  default = 10
}

variable "storage_type" {
  description = "Type of storage"
  default = "gp2"
}

variable "database_version" {
  description = "The database version. If omitted, it lets Amazon decide."
  default = ""
}

variable "database_instance_class" {
  description = "The instance type of the database instance."
  default = "db.t2.micro"
}

variable "database_name" {
  description = "The name of the database schema to create. If omitted, no database schema is created initially."
  default = "testdb" 
}

variable "database_master_user" {
  description = "The password for the master database user."
  default = "admin"
}

variable "database_master_user_password" {
  description = "The username for the master database user."
  default = "thisIsNotAGoodIdea"
}

variable "database_port" {
  description = "The port the database listens on. 3306 by default."
  default = "3306"
}

variable "backup_retention_period" {
  description = "The number of days to retain database backups."
  default = 7
}

variable "backup_window" {
  description = "The time window in which backups should take place."
  default = "01:00-03:00"
}

variable "maintenance_window" {
  description = "The time window in which maintenance should take place."
  default = "mon:03:01-mon:05:00"
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

variable "name" {
    description = "The name for this database"
    default = "RDS MySQL Database"
}

