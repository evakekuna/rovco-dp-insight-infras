terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

#terraform {
#  required_version = ">= 0.13"
#
#  backend "s3" {
#    region  = "eu-west-2"
#    profile = ""
#    bucket  = ""
#    key     = "dev.terraform.tfstate"
#  }
#}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

module "network" {
  source = "./network"

  app_name = var.app_name
  env = var.env
}

module "data_storage" {
  source = "./data"

  app_name = var.app_name
  env = var.env
}
