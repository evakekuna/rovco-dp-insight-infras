/**
 * main.tf
 * The main entry point for Terraform run
 * See variables.tf for common variables
 * See state.tf for creation of S3 bucket for remote state and 
 * remote state locking 
 */

terraform {
  required_version = ">= 0.12"
}

/**
Using the AWS Provider with a shared credentials file 
for local development 
*/

# https://www.terraform.io/docs/providers/
provider "aws" {
  version                 = ">= 2.23.0"
  shared_credentials_file = "$HOME/.aws/credentials"
  region                  = var.aws_region
  profile                 = var.aws_profile
}

provider "aws" {
  alias  = "replica"
  region = var.aws_region_replica
}

resource "aws_iam_user" "terraform" {
  name = "dp_terraform_user"
}

resource "aws_iam_user_policy_attachment" "remote_state_access" {
  user       = aws_iam_user.terraform.name
  policy_arn = module.tf_remote_state.terraform_iam_policy.arn
}

/*
 * Outputs
 * Results from a successful Terraform run (terraform apply)
 * To see results after a successful run, use `terraform output [name]`
 */

# Returns the name of the S3 bucket that will be used in later Terraform files
output "state_bucket" {
  value = module.tf_remote_state.state_bucket
}

output "replica_bucket" {
  value = module.tf_remote_state.replica_bucket
}

# Returns the name of the ECR registry, this will be used later in various scripts
output "container_registry" {
  value = aws_ecr_repository.app.repository_url
}

