resource "aws_cloudfront_distribution" "roboshop" {
  origin {
    domain_name              = "frontend-${var.environment}.${var.domain_name}"
    origin_id                =  "frontend-${var.environment}.${var.domain_name}"
  }
   custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
     enabled             = true
    is_ipv6_enabled     = false

  aliases = ["${var.project}-${var.environment}.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    viewer_protocol_policy = "https-only"
    cache_policy_id          = local.cache_disabled

    }


  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    viewer_protocol_policy = "https-only"
    cache_policy_id          = local.cache_optimized
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD","OPTIONS"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    viewer_protocol_policy = "https-only"
    cache_policy_id          = local.cache_optimized
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN"]
    }
  }

  tags = merge(local.common_tags,
   {
    terraform = "true"
  }
  )

  viewer_certificate {
    acm_certificate_arn = data.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }


# Create Route53 records for the CloudFront distribution aliases

resource "aws_route53_record" "cloudfront" {
  zone_id  = var.zone_id
  name     = "${var.project}-${var.environment}-${var.domain_name}"
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.roboshop.domain_name
    zone_id                = aws_cloudfront_distribution.roboshop.hosted_zone_id
    evaluate_target_health = false
  }
  allow_overwrite = true
}