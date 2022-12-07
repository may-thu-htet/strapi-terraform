module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = local.bucket_name

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  attach_policy = true
  policy        = jsonencode(local.s3_bucket_policy)

  versioning = {
    enabled = false
  }

  force_destroy = true

  tags = {
    Name = "${var.prefix}"
  }
}

locals {
  bucket_name = "${var.prefix}-media"
  s3_bucket_policy = {
    "Version" : "2012-10-17",
    "Id" : "Policy1670128902121",
    "Statement" : [
      {
        "Sid" : "Stmt1670128897352",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::strapi-stage-media/*"
      }
    ]
  }
}
