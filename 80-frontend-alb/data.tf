data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project}/${var.environment}/public_subnet_ids"
}
data "aws_ssm_parameter" "frontend_alb_certificate_arn" {
    name = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"
}
data "aws_ssm_parameter" "frontend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/frontend_alb_sg_id"
}

resource "aws_ssm_parameter" "frontend_alb_listener_arn" {
  name  = "/${var.project}/${var.environment}/frontend_alb_listener_arn"
  type  = "String"
  value = aws_lb_listener.https.arn
  }