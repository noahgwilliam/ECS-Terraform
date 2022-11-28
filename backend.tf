terraform {
  required_version = "<a version>"

  backend "s3" {
    bucket = "terraform.<bucket name>"
    key    = "microservices/env-1/<app>/terraform.tfstate"
    region = "<region>"
  }
}