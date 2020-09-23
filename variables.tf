variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "env" {
  type = string
}

# App vars
variable "app_name" {
  type = string
  description = "Frontend App name"
}

variable "frontend_app_name" {
  type = string
  description = "Frontend App name"
}

variable "api_app_name" {
  type = string
  description = "API App name"
}

# ECS cluster vars

# ECS cluster variables | ecs-cluster-variables.tf
variable "cluster_runner_type" {
  type = string
  description = "EC2 instance type of ECS Cluster Runner"
}
variable "cluster_runner_count" {
  type = string
  description = "Number of EC2 instances for ECS Cluster Runner"
}


