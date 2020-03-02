resource "aws_security_group" "lambda_security_group" {
  name        = "lambda-security-group"
  description = "Allow lambda output access to everything."
  vpc_id      = var.vpc_id

  tags = {
    Name                 = "Lambda Security Group"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


