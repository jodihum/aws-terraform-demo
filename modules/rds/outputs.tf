output "database_name" {
  value  = aws_db_instance.rds_mysql.name
  description = "The name of the database"
}

output "database_master_user" {
  value  = aws_db_instance.rds_mysql.username
  description = "The username for the database"
}

output "database_master_user_password" {
  value  = aws_db_instance.rds_mysql.password
  description = "The password for the database"
}

output "database_port" {
  value  = var.database_port
  description = "The port used by the database"
}

