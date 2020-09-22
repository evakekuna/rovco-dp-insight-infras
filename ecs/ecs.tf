/**
* This provisions the ECS cluster 
*/

# Number of containers to be run 
variable "replicas" {
  default = "1"
}

# name of the application
variable "container_name" {
  default = "app"
}

# See autoscale tfs for scaling but minimum is of course 1 
# Should be two in stag and prod? 
variable "ecs_autoscale_min_instances" {
  default = "1"
}

# Set the Max number of containers to run  
variable "name" {
  default = "4"
}

resource "aws_ecs_cluster" "app" {
  name = "var.app"
  tags = var.tags
}


resource "aws_appautoscaling_target" "app_scale_target" {
  max_capacity       = var.ecs_autoscale_max_instances
  min_capacity       = var.ecs_autoscale_max_instances
  resource_id        = "service/${aws_ecs_cluster.app.name}/${aws_ecs_service.app.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "var.app-var.environment"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs.TaskExecutionRole.arn
  container_definitions    = "Required"

  tags = var.tags
}

resource "aws_ecs_service" "aws_ecs_service_suffix" {
  name            = "var.app-var.environment"
  task_definition = "Required"

  desired_count = var.replicas

  launch_type = "FARGATE"

  cluster = aws_ecs_cluster.app.id

  enable_ecs_managed_tags = true

  propagate_tags = "SERVICE"

  load_balancer = {
    target_group_arn = aws_alb_target_group.main.id
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    security_groups = [aws_security_group.nsg_task.id]
    subnets         = split(",", var.private_subnets)
  }

  depends_on = [aws_alb_listener.http]


  tags = var.tags
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "var.app-var.environment-ecs"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "logs_retention_in_days" {
  type        = number
  default     = 5
  description = "Specifies the number of days you want to retain log events"
}

resource "aws_cloudwatch_log_group" "logs" {
  name              = "/fargate/service/var.app-var.environment"
  retention_in_days = var.logs_retention_in_days
  tags              = var.tags
}
