locals {
    frontend_alb_certificate_arn = data.aws_ssm_parameter.frontend_alb_certificate_arn.value
    cache_disabled = data.aws_cloudfront_cache_policy.cache_disabled.id
    cache_optimized = data.aws_cloudfront_cache_policy.cache_optimized.id
    common_tags = {
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
}