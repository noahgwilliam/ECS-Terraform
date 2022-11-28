resource "aws_lb_listener_rule" "live_listener_rule" {
  listener_arn = var.live_listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = var.target_group_1_arn
  }

  condition {
    path_pattern {
      values = ["/${var.application}/*"]
    }
  }
  tags = local.common_tags
}

resource "aws_lb_listener_rule" "test_listener_rule" {
  listener_arn = var.test_listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = var.target_group_1_arn
  }

  condition {
    path_pattern {
      values = ["/${var.application}/*"]
    }
  }
  tags = local.common_tags
}