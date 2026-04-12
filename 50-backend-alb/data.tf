data "aws_ssm_parameter" "backend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/backend_alb_sg_id"
}
data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project}/${var.environment}/private_subnet_ids"
}
resource "aws_ssm_parameter" "backend_alb_listener_arn" {
  count = length(var.sg_names)
  name  = "/${var.project}/${var.environment}/${var.backend_alb_listener_arn}"
  type  = "String"
  value = aws_lb_listener.http.arn
  }