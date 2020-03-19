locals {
  common_tags = {
    project      = var.project
    module       = "kms"
    Owner        = var.owner
  }
}

resource "aws_kms_key" "rds_key" {
  description = "Key for encrypting RDS"
  enable_key_rotation = true

  tags = local.common_tags
}

resource "aws_kms_alias" "rds_key" {
  name = "alias/rds_key"
  target_key_id = aws_kms_key.rds_key.id
}
