terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

terraform {
  required_version = ">= 0.13"

  backend "s3" {
    region  = "eu-west-2"
    profile = ""
    bucket  = ""
    key     = "dev.terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}
