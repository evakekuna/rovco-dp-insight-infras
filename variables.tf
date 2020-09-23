variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-2"
}

variable "env" {
  type = string
  default = "terraform"
}

# App vars
variable "app_name" {
  type = string
  description = "Frontend App name"
  default = "rovco-dp-insight"
}

variable "frontend_app_name" {
  type = string
  description = "Frontend App name"
  default = "rovco-dp-insight-frontend"
}

variable "api_app_name" {
  type = string
  description = "API App name"
  default = "rovco-dp-insight-api"
}

# ECS cluster vars

# ECS cluster variables | ecs-cluster-variables.tf
variable "cluster_runner_type" {
  type = string
  description = "EC2 instance type of ECS Cluster Runner"
  default = "t3.medium"
}
variable "cluster_runner_count" {
  type = string
  description = "Number of EC2 instances for ECS Cluster Runner"
  default = "1"
}


