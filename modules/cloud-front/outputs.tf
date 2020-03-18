output "domain_name" {
  value = aws_cloudfront_distribution.ag_distribution.domain_name
  description = "The domain name for the cloud front"
}
