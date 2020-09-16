# state.tf 
# This runs a module https://github.com/nozaq/terraform-aws-remote-state-s3-backend
# to implement remote state in s3 

module "tf_remote_state" {
  source = "nozaq/remote-state-s3-backend/aws"
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }

  dynamodb_table_name = "dp_insight_app_tf_remote_state_lock"
  tags = {
    Terraform      = "True"
    dp_insight_tag = "FS"
  }
  replica_bucket_prefix = "dp-insight-terraform-state-replica"
  state_bucket_prefix   = "dp-insight-terraform-state"
}
