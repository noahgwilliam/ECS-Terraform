resource "aws_codedeploy_deployment_group" "app_deployment" {
  app_name               = var.codedeploy_app_name
  deployment_group_name  = "<prefix>-${var.application}"
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  service_role_arn       = data.aws_iam_role.codedeploy_service_role.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 0
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.cluster_name
    service_name = "<prefix>-${var.application}"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.live_listener_arn]
      }
      test_traffic_route {
        listener_arns = [var.test_listener_arn]
      }
      target_group {
        name = aws_lb_target_group.ecs-1.name
      }
      target_group {
        name = aws_lb_target_group.ecs-2.name
      }
    }
  }

  depends_on = [
    aws_ecs_service.app_service,
  ]

  tags = local.common_tags

}