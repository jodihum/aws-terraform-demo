output "key_arn" {
  value  = aws_kms_key.rds_key.arn
  description = "The alias for the encryption key"
}
