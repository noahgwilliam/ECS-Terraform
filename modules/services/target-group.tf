resource "aws_lb_target_group" "ecs-1" {
  name                 = "<prefix>-${var.environment}-${var.application}-tg-1"
  port                 = 80
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = "5"

  health_check {
    path = "<path>"
  }
  tags = local.common_tags
}

resource "aws_lb_target_group" "ecs-2" {
  name                 = "<prefix>-${var.environment}-${var.application}-tg-2"
  port                 = 80
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = "5"

  health_check {
    path = "<path>"
  }
  tags = local.common_tags
}
