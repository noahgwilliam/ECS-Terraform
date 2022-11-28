terraform {
  required_version = "<version>"

  backend "s3" {
    bucket = "terraform.<bucket name>"
    key    = "microservices/all/common/terraform.tfstate"
    region = "<region>"
  }
}