resource "aws_kms_key" "rds_key" {
  count = var.should_encrypt == "yes" ? 1 : 0

  description = "Key for encrypting RDS"
  enable_key_rotation = true

  tags = local.common_tags
}

//resource "aws_kms_alias" "rds_key" {
//  count = var.should_encrypt == "yes" ? 1 : 0
//  name = "alias/rds_key"
//  target_key_id = aws_kms_key.rds_key.id
//}
