resource "aws_s3_bucket" "this" {
  acl    = "private"
  bucket = local.s3_bucket_name

  tags = {
    Name        = local.s3_bucket_name
    Product     = var.product
    Environment = var.environment
    Description = var.s3_bucket_description
    ManagedBy   = "terraform"
  }

  logging {
    target_bucket = local.s3_logging_bucket
    target_prefix = "${local.s3_bucket_name}/"
  }

  versioning {
    enabled = var.s3_enable_versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.s3_sse_algorithm
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.s3_bucket.json
}

resource "aws_ssm_document" "this" {
  name            = var.session_manager_document_name
  document_type   = "Session"
  document_format = "JSON"

  tags = {
    Name        = local.ssm_document_name
    Product     = var.product
    Description = var.ssm_document_description
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  content = <<DOC
{
    "schemaVersion": "1.0",
    "description": "${var.ssm_document_description}",
    "sessionType": "Standard_Stream",
    "inputs": {
        "s3BucketName": "${local.s3_bucket_name}",
        "s3KeyPrefix": "${var.s3_bucket_prefix}",
        "s3EncryptionEnabled": true,
        "cloudWatchLogGroupName": "",
        "cloudWatchEncryptionEnabled": false
    }
}
DOC
}

resource "aws_iam_policy" "this" {
  name   = local.iam_policy_name
  policy = data.aws_iam_policy_document.session_manager.json
}
