data "aws_lb" "env_alb" {
  name = "<name>-${var.environment}-alb"
}

data "aws_lb_listener" "live" {
  load_balancer_arn = data.aws_lb.env_alb.arn
  port              = 80
}

data "aws_lb_listener" "test" {
  load_balancer_arn = data.aws_lb.env_alb.arn
  port              = 81
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = "<cluster name>-${var.environment}"
}