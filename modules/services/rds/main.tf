module "vpc" {
  source = "../vpc"
}

resource "aws_db_instance" "rds_mysql" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = "mysql"
  engine_version       = var.database_version
  instance_class       = var.database_instance_class
  name                 = var.database_name
  username             = var.database_master_user
  password             = var.database_master_user_password
  snapshot_identifier  = var.snapshot_identifier
  publicly_accessible  = false
  multi_az             = true
#  storage_encrypted    = true
  skip_final_snapshot  = true
  db_subnet_group_name = var.subnet_group_name

  vpc_security_group_ids = [
    aws_security_group.mysql_database_security_group.id
  ]

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  tags = {
    Name                 = "RDS MySQL Database"
  }
}


