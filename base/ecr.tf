# Sets up an ECR repo for the containers / application environments

# The tag mutability setting for the repository (defaults to IMMUTABLE)
variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "The tag mutability setting for the repository (defaults to IMMUTABLE)"
}

# create an ECR repo at the app/image level
resource "aws_ecr_repository" "app" {
  name                 = var.app
  image_tag_mutability = var.image_tag_mutability
}

data "aws_caller_identity" "current" {
}

# IAM policy document 
data "aws_iam_policy_document" "ecr" {
  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
      "ecr:GetLifecyclePolicy",
      "ecr:PutLifecyclePolicy",
      "ecr:DeleteLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:StartLifecyclePolicyPreview",
    ]
    
    principals {
      type = "AWS"

      identifiers = var.principals_full_access
    }
  }
}

# grant access to saml users
resource "aws_ecr_repository_policy" "app" {
  repository = aws_ecr_repository.app.name
  policy     = data.aws_iam_policy_document.ecr.json
}


