resource "aws_lb" "network_load_balancer" {
  name               = "<prefix>-${var.application}-${var.environment}-nlb"
  internal           = "true"
  load_balancer_type = "network"
  subnets            = split(";", local.lb_subnets)

  tags = local.common_tags
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.network_load_balancer.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.<prefix>_alb_tg.arn
  }

  tags = local.common_tags
}

resource "aws_lb_target_group" "<prefix>_alb_tg" {
  name        = "<prefix>-${var.environment}-${var.application}-alb-tg"
  port        = 80
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  health_check {
    enabled = true
    path    = "<path>"
  }
  tags = local.common_tags
}

resource "aws_lb_target_group_attachment" "<prefix>_alb_tg_attachment" {
  target_group_arn = aws_lb_target_group.<prefix>_alb_tg.arn
  target_id        = aws_lb.application_load_balancer.arn
  port             = 80
  depends_on = [
    aws_lb_target_group.<prefix>_alb_tg,
    aws_lb.application_load_balancer,
  ]
}