# frontend app
resource "aws_s3_bucket" "dp_insight_frontend_app" {

  bucket = "${var.app_name}-${var.env}-frontend-app"
  acl = "private"
  tags = {
    Name = "Insight Frontend App"
    Environment = var.env
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_cloudfront_origin_access_identity" "dp_insight_frontend_cloudfront_origin_access_identity" {
  comment = "${var.env} - Access Identity For Frontend App"
}