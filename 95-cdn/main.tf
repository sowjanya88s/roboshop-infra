resource "aws_cloudfront_distribution" "alb_distribution" {
  origin {
    domain_name = "frontend-${var.environment}.${domain_name}"
    origin_id   = "frontend-${var.environment}.${domain_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only" # or "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = false
  aliases = "${var.project}-${var.environment}.${domain_name}"
  
 default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "frontend-${var.environment}.${domain_name}"
    viewer_protocol_policy =  "https-only"
    cache_policy_id = local.cache_disabled
  }
 default_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "frontend-${var.environment}.${domain_name}"
    viewer_protocol_policy =  "https-only"
    cache_policy_id = local.cache_optimized
  }
  default_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "frontend-${var.environment}.${domain_name}"
    viewer_protocol_policy =  "https-only"
    cache_policy_id = local.cache_optimized
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = local.frontend_alb_certificate_arn
    ssl_support_method = "sni-only"
  }
   tags = merge(var.common_tags,
   {
    Name = "${var.project}-${var.environment}-frontend"
  }
   )

}

resource "aws_route53_record" "cloudfront" {

  zone_id  = var.zone_id
  name     = "${var.project}-${var.environment}.${var.domain_name}"
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.alb_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.alb_distribution.hosted_zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}
