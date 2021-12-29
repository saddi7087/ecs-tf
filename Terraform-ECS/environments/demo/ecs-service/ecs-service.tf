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

module "ecs-service" {
  source             = "../../../modules/ecs-service"
  aws_region         = var.aws_region
  aws_profile        = var.aws_profile
  environment        = var.environment
  name               = var.name
  availability_zones = var.availability_zones
  public_subnets_ids = var.public_subnets_ids
  container_port     = var.container_port
  container_image    = var.container_image
  ecs_cluster        = var.ecs_cluster

}
