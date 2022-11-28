resource "aws_ecr_repository" "ecr_repository" {
  name                 = "<ecr name>"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
    tags = local.common_tags
}