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
  name = "${var.app}"
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
  family                   = "${var.app}-${var.environment}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs.TaskExecutionRole.arn
  container_definitions    = "Required"


}


