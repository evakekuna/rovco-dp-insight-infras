terraform {
  required_version = ">= 0.12"

  backend "s3" {
    region  = "eu-west-2"
    profile = ""
    bucket  = "dp-insight-terraform-state20200917161034887200000002"
    key     = "ecs_api.terraform.tfstate"
  }
}

# The AWS Profile to use
variable "aws_profile" {
}

provider "aws" {
  version                 = ">= 2.27.0, < 3.0.0"
  shared_credentials_file = "$HOME/.aws/credentials"
  region                  = var.aws_region
  profile                 = var.aws_profile
}

# Command to set the AWS_PROFILE
output "aws_profile" {
  value = var.aws_profile
}
