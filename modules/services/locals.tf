locals {
  lb_subnets = "${var.private-aza};${var.private-azb};${var.private-azc}"
}
locals {
  common_tags = {
    Terraform   = "true"
    Environment = title(var.environment)
  }
}