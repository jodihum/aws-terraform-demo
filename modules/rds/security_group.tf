resource "aws_security_group" "mysql_database_security_group" {
  name        = "mysql-database-security-group"
  description = "Allow access to MySQL database from private network."
  vpc_id      = var.vpc_id

  ingress {
    from_port = var.database_port
    to_port   = var.database_port
    protocol  = "tcp"
    security_groups = [var.lambda_security_group]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", "MySQL Security Group"
    )
  )
}

