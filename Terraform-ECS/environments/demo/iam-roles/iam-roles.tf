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

module "ecs-iam-roles" {
  source      = "../../../modules/ecs-iam-roles"
  environment = "demo"
}
