provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "aws-ecr" {
  source              = "../../../modules/aws-ecr"
  ecr_repository_name = "demo-app-1"
  image_mutability    = "MUTABLE"
  scan_on_push        = "true"
  appname             = "demo-app"

}
