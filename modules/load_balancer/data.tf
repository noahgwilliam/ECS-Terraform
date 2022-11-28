data "aws_security_group" "application_load_balancer" {
  tags = {
    Name = "<prefix>-${var.environment}-alb"
  }
}