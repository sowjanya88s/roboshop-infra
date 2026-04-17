locals {
    common_tags = {
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
    cache_optimized = data.aws_cloudfront_cache_policy.cache_optimized.id
    cache_disabled = data.aws_cloudfront_cache_policy.cache_disabled.id
    acm_certificate_arn = data.aws_ssm_parameter.acm_certificate_arn.value
}