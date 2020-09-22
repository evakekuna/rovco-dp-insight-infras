/*
 * Common variables to use in various base Terraform files (*.tf)
 */

# Using local AWS credentails profile 
variable "aws_profile" {
  default = "default"
}

# Main AWS region (london)
variable "aws_region" {
  default = "eu-west-2"
}

# Region for state replication (Ireland)
variable "aws_region_replica" {
  default = "eu-west-1"
}

# The role that will have access to the S3 bucket, this should be a role that all
# members of the team have access to.
# variable "saml_role" {
# }

variable "principals_full_access" {
  type        = list(string)
  description = "Principal ARNs to provide with full access to the ECR"
  default     = []
}

# Name of the application.
variable "app" {
  description = "Name of the whole application"
}
