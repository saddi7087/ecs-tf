resource "aws_ecr_repository" "ecr" {
  name                 = var.ecr_repository_name
  image_tag_mutability = var.image_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = {
    provisioner = "terraform"
    app         = var.appname
  }
}
