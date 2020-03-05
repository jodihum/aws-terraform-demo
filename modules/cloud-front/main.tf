locals {
  common_tags = {
    project      = var.project
    module       = "cloud-front"
    Owner        = var.owner
  }
} 

resource "aws_cloudfront_distribution" "ag_distribution" {
  origin {
    domain_name = replace(var.api_gateway_invoke_url, "/^https?://([^/]*).*/", "$1")
    origin_path = format("/%s", var.api_gateway_stage_name)
    origin_id   = format("Custom-%s",var.api_gateway_invoke_url)

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1.2"]
    }

  }
  enabled = true

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = format("Custom-%s",var.api_gateway_invoke_url)

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  tags = merge(
    local.common_tags,
    map(
      "Name", var.distribution_name
    )
  )
}

