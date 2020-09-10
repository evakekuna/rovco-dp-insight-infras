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
variable "saml_role" {
}


# Name of the application. This value should usually match the application tag below.
variable "app" {
}
