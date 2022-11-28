data "aws_security_group" "ecs_sg" {
  tags = {
    Name = "<name>-${var.environment}-ecs"
  }
}

data "aws_iam_role" "codedeploy_service_role" {
  name = "<name>"
}