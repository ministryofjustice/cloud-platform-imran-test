resource "aws_s3_bucket" "bucket" {
  // WARNING: if you edit the bucket name, be sure to edit the policy document to match otherwise it will error!
  bucket        = "${local.namespace}-${var.bucket_purpose}" // read the above warning!
  acl           = "private"
  force_destroy = "${var.force_destroy_s3_bucket}"

  versioning {
    enabled = true
  }

  policy = "${data.aws_iam_policy_document.s3_bucket.json}"

  lifecycle_rule {
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 180
    }
  }

  tags = {
    Name         = "Terraform State File Bucket"
    environment  = "${var.environment}"
    project_name = "${var.project_name}"
  }
}

data "aws_iam_policy_document" "s3_bucket" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:root"]
    }

    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${local.namespace}-${var.bucket_purpose}",
      "arn:aws:s3:::${local.namespace}-${var.bucket_purpose}/*",
    ]
  }
}

output "bucket_name" {
  value = "${aws_s3_bucket.bucket.id}"
}
