resource "aws_security_group" "mysql_database_security_group" {
  name        = "database-security-group"
  description = "Allow access to MySQL database from private network."
  vpc_id      = var.vpc_id

  tags = {
    Name                 = "sg-database-${var.component}-${var.deployment_identifier}"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }

  ingress {
    from_port = var.database_port
    to_port   = var.database_port
    protocol  = "tcp"
    cidr_blocks = [
      var.private_network_cidr
    ]
  }
}
