


/******************** Providers ********************/

provider "aws" {
  alias  = "<alias/region>"
  region = "<region"
}

/******************** AWS Defaults ********************/

variable "aws_region" {
  default = "<region>"
}

/******************** Modules for All Microservices ********************/

