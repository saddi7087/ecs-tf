resource "aws_ecs_cluster" "cluster" {
  name = "demo-app-${var.environment}"

  tags = {
    provisioner = "terraform"
    Environment = var.environment
  }
}

output "ecs-id" {
  value = aws_ecs_cluster.cluster.id
}
