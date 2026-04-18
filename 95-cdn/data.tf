
data "aws_ssm_parameter" "frontend_alb_certificate_arn" {
    name = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"
}
data "aws_cloudfront_cache_policy" "cache_optimized" {
  name = "Managed-CachingOptimized"
}
data "aws_cloudfront_cache_policy" "cache_disabled" {
  name = "Managed-CachingDisabled"
}
