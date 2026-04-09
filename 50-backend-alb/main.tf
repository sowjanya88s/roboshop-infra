resource "aws_lb" "backend_alb" {
  name               = "${var.project}-${var.environment}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_ids

  enable_deletion_protection = false

  tags = merge(var.common_tags,
  {
    Name = "${var.project}-${var.environment}-backend-alb"
  }
  )
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "<h1> this response is from backend-alb </h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "*.backend-alb-${var.environment}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.backend_alb.dns_name
    zone_id                = aws_lb.backend_alb.zone_id
    evaluate_target_health = true
  }
}