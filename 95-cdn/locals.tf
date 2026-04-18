locals {
    frontend_alb_certificate_arn = data.aws_ssm_parameter.frontend_alb_certificate_arn.value
    frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value
    backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
    cache_disabled = data.aws_cloudfront_cache_policy.cache_disabled.id
    cache_optimized = data.aws_cloudfront_cache_policy.cache_optimized.id
    common_tags = {
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
}