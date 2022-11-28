module "<app>_services" {
  source                       = "./modules/services"
  environment                  = var.environment
  vpc_id                       = var.vpc_id
  private-aza                  = var.private-aza
  private-azb                  = var.private-azb
  private-azc                  = var.private-azc
  codedeploy_app_name          = var.codedeploy_app_name
  application                  = "<app>"
  ecs_task_definition_arn      = "arn:<an arn>"
  ecs_desired_containers_count = 1
  ecs_autoscale_min_instances  = 1
  ecs_autoscale_max_instances  = 1
  cluster_name                 = data.aws_ecs_cluster.cluster.cluster_name #if new, refer to cluster module
  cluster_id                   = data.aws_ecs_cluster.cluster.id
  live_listener_arn            = data.aws_lb_listener.live.arn
  test_listener_arn            = data.aws_lb_listener.test.arn
}

module "<app>_alb_listener_rules" {
  source             = "./modules/alb_listener_rules"
  environment        = var.environment
  application        = "<app>"
  priority           = <unique priority>
  live_listener_arn  = data.aws_lb_listener.live.arn
  test_listener_arn  = data.aws_lb_listener.test.arn
  target_group_1_arn = module.<app>_services.aws_lb_target_group_ecs_1_arn
  target_group_2_arn = module.<app>_services.aws_lb_target_group_ecs_2_arn
}