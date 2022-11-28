resource "aws_lb" "application_load_balancer" {
  name               = "<prefix>-${var.application}-${var.environment}-alb"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.application_load_balancer.id]
  subnets            = split(";", local.lb_subnets)

  tags = local.common_tags
}

resource "aws_lb_listener" "live_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Path does not exist."
      status_code  = "404"
    }
  }
  tags = local.common_tags
}

resource "aws_lb_listener_rule" "live_alb_health_rule" {
  listener_arn = aws_lb_listener.live_listener.arn
  priority     = 50000

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "HEALTHY"
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
      values = ["<path>"]
    }
  }
  tags = local.common_tags
}

resource "aws_lb_listener" "test_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 81
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Path does not exist."
      status_code  = "404"
    }
  }
  tags = local.common_tags
}

resource "aws_lb_listener_rule" "test_alb_health_rule" {
  listener_arn = aws_lb_listener.test_listener.arn
  priority     = 50000

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "HEALTHY"
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
      values = ["<path>"]
    }
  }
  tags = local.common_tags
}