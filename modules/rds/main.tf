locals {
  common_tags = {
    project      = var.project
    module       = "rds"
    Owner        = var.owner
  }
}

resource "aws_db_instance" "rds_mysql" {

  // subscription must be set up before instance is created so we can 
  // handle creation event
  depends_on = [aws_db_event_subscription.rds_created]
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = "mysql"
  engine_version       = var.database_version
  instance_class       = var.database_instance_class
  name                 = var.database_name
  username             = var.database_master_user
  password             = var.database_master_user_password
  publicly_accessible  = false
  multi_az             = true
  storage_encrypted    = var.should_encrypt == "yes" ? true : false
  kms_key_id           = var.key
  skip_final_snapshot  = true
  db_subnet_group_name = var.subnet_group_name

  vpc_security_group_ids = [
    aws_security_group.mysql_database_security_group.id
  ]

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  tags = merge(
    local.common_tags,
    map(
      "Name", var.name             
    )
  )
}


