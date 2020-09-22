# unstructured client data
resource "aws_s3_bucket" "dp_insight_unstructured_data" {

  bucket = "${var.app_name}-${var.env}-unstructured-data"
  acl = "private"
  tags = {
    Name = "Insight Unstructured Data"
    Environment = var.env
  }
}

resource "aws_cloudfront_origin_access_identity" "dp_insight_unstructured_data_cloudfront_origin_access_identity" {
  comment = "${var.env} - Access Identity For Unstructured Data"
}