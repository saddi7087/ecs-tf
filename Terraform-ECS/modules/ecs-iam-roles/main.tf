// AWS IAM Linked EC2Role used for ecs service
resource "aws_iam_role" "ecsInstanceRole" {
  name = "ecsInstanceRole-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "EC2ContainerServicePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerServiceforEC2Role" {
  name       = "AmazonEC2ContainerServiceforEC2Role"
  roles      = [aws_iam_role.ecsInstanceRole.name]
  policy_arn = data.aws_iam_policy.EC2ContainerServicePolicy.arn
}

// IAM Role for ECS (which allow ECS to attach network interfaces to instances on your behalf in order for awsvpc networking mode to work right & Rules which allow ECS to update load balancers on your behalf with the information about how to send traffic to your containers)
resource "aws_iam_role" "ecsRole" {
  name = "ecsRole-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "AmazonEC2ContainerServicePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerServiceRole" {
  name       = "AmazonEC2ContainerServiceRole"
  roles      = [aws_iam_role.ecsRole.name]
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerServicePolicy.arn
}

// IAM Role for task execution role(Allow the ECS Tasks to download images from ECR & Allow the ECS tasks to upload logs to CloudWatch)

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = "ecsTaskExecutionRole-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "AmazonECSTaskExecutionPolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy_attachment" "AmazonECSTaskExecutionRolePolicy" {
  name       = "AmazonECSTaskExecutionRolePolicy"
  roles      = [aws_iam_role.ecsTaskExecutionRole.name]
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionPolicy.arn
}

// IAM Role for Autoscaling
resource "aws_iam_role" "ecsAutoscalingRole" {
  name = "ecsAutoscalingRole-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "application-autoscaling.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "AmazonEC2ContainerServiceAutoscalePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerServiceAutoscaleRole" {
  name       = "AmazonEC2ContainerServiceAutoscaleRole"
  roles      = [aws_iam_role.ecsAutoscalingRole.name]
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerServiceAutoscalePolicy.arn
}

output "ecsAutoscalingRole-arn" {
  value = aws_iam_role.ecsAutoscalingRole.arn
}

output "ecsTaskExecutionRole-arn" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "ecsRole-name" {
  value = aws_iam_role.ecsRole.arn
}

output "ecsInstanceRole-name" {
  value = aws_iam_role.ecsInstanceRole.arn
}
