locals {
  common_tags = {
    Terraform   = "true"
    Environment = title(var.environment)
  }
}