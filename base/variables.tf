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
