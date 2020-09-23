variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-2"
}

variable "app_name" {
  type = string
}

variable "env" {
  type = string
}