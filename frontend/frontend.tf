

resource "aws_cloudfront_origin_access_identity" "dp_insight_frontend_cloudfront_origin_access_identity" {
  comment = "${var.env} - Access Identity For Frontend App"
}


# OPTIONAL: Specify a user that will be able to upload stuff to bucket
resource "aws_iam_user" "prod_user" {
    name = "${var.frontend_app_name}-bucket-user"
    path = "/system/"
    tags = {
      Environment = var.env
    }
}
# OPTIONAL: Creates keys for that user
resource "aws_iam_access_key" "prod_user_key" {
    user = aws_iam_user.prod_user.name
}

# OPTIONAL: Policy for user that allows it to upload
resource "aws_iam_user_policy" "prod_user_ro" {
    name = "prod"
    user = aws_iam_user.prod_user.name
    policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": [
            "arn:aws:s3:::${var.frontend_app_name}-${var.env}-bucket",
            "arn:aws:s3:::${var.frontend_app_name}-${var.env}-bucket/*"
        ]
     }]
}
EOF
}

# Here we specify the bucket
resource "aws_s3_bucket" "dp_insight_frontend_app" {
    bucket = "${var.frontend_app_name}-${var.env}-bucket"
    acl = "private"
    policy= <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
  {
      "Sid": "PublicReadForGetBucketObjects",
      "Effect": "Allow",
      "Principal": {
          "AWS": "*"
       },
       "Action": "s3:GetObject",
       "Resource": "arn:aws:s3:::${var.frontend_app_name}-${var.env}-bucket/*"
  }, {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
          "AWS": "${aws_iam_user.prod_user.arn}"
      },
      "Action": "s3:*",
      "Resource": [
          "arn:aws:s3:::${var.frontend_app_name}-${var.env}-bucket",
          "arn:aws:s3:::${var.frontend_app_name}-${var.env}-bucket/*"
      ]
  }]
}
EOF
    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }
    tags = {
      Name = "Insight Frontend App"
      Environment = var.env
    }
    website {
      index_document = "index.html"
    }
}
# Create Cloudfront distribution
resource "aws_cloudfront_distribution" "prod_distribution" {
    origin {
        domain_name = aws_s3_bucket.dp_insight_frontend_app.bucket_regional_domain_name
        origin_id = "S3-${aws_s3_bucket.dp_insight_frontend_app.bucket}"

        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "match-viewer"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
        }
    }
    # By default, show index.html file
    default_root_object = "index.html"
    enabled = true
    # If there is a 404, return index.html with a HTTP 200 Response
    custom_error_response {
        error_caching_min_ttl = 3000
        error_code = 404
        response_code = 200
        response_page_path = "/index.html"
    }
    default_cache_behavior {
        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.dp_insight_frontend_app.bucket}"
        # Forward all query strings, cookies and headers
        forwarded_values {
            query_string = true
            cookies {
                forward = "none"
            }
        }
        viewer_protocol_policy = "allow-all"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }
    # Distributes content to US and Europe
    price_class = "PriceClass_100"
    # Restricts who is able to access this content
    restrictions {
        geo_restriction {
            # type of restriction, blacklist, whitelist or none
            restriction_type = "none"
        }
    }
    # SSL certificate for the service.
    viewer_certificate {
        cloudfront_default_certificate = true
    }
    tags = {
      Name = "Insight Frontend App"
      Environment = var.env
    }
}