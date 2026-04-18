data "aws_ssm_parameter" "frontend_alb_listener_arn" {
    value = "/${var.project}/${var.environment}/frontend_alb_listener_arn"
}
data "aws_ssm_parameter" "backend_alb_listener_arn" {
    value = "/${var.project}/${var.environment}/backend_alb_listener_arn"
}
data "aws_ssm_parameter" "frontend_alb_certificate_arn" {
    value = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"
}
data "aws_cloudfront_cache_policy" "cache_optimized" {
  name = ""
}
