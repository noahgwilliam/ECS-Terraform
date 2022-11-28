resource "aws_ecs_service" "app_service" {
  name          = "<prefix>-${var.application}"
  cluster       = var.cluster_id
  desired_count = var.ecs_desired_containers_count
  launch_type   = "FARGATE"
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-1.arn
    container_name   = "<prefix>-${var.application}"
    container_port   = 8080
  }
  network_configuration {
    subnets          = split(";", local.lb_subnets)
    security_groups  = [data.aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }
  platform_version        = "1.4.0"
  enable_ecs_managed_tags = true
  task_definition         = var.ecs_task_definition_arn

  lifecycle {
    # We ignore changes to the task_definition because this is changed by CodeDeploy
    ignore_changes = [
      task_definition
    ]
  }

  tags = local.common_tags

}

resource "aws_appautoscaling_target" "app_scale_target" {
  count              = (var.ecs_autoscale_max_instances > var.ecs_autoscale_min_instances) ? 1 : 0
  service_namespace  = "ecs"
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.app_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.ecs_autoscale_max_instances
  min_capacity       = var.ecs_autoscale_min_instances
}