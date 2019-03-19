data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_role" "super_admin" {
  name = "SuperAdmin"
}

data "aws_iam_policy_document" "session_manager" {
  statement = {
    sid    = "AllowConnectToSSMServer"
    effect = "Allow"

    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply",
      "ssm:DescribeAssociation",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:DescribeDocument",
      "ssm:GetManifest",
      "ssm:GetParameters",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutInventory",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation",
    ]

    resources = ["*"]
  }

  statement = {
    sid    = "AllowEC2InstancesToConnectToSessionManagerServer"
    effect = "Allow"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]

    resources = [
      "*",
    ]
  }

  statement = {
    sid    = "AllowEC2InstancesToGetBucketEncryption"
    effect = "Allow"

    actions = [
      "s3:GetEncryptionConfiguration",
    ]

    resources = ["${aws_s3_bucket.this.arn}"]
  }

  statement = {
    sid    = "AllowEC2ToStoreLogsToS3Bucket"
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetEncryptionConfiguration",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [
      "${aws_s3_bucket.this.arn}",
      "${aws_s3_bucket.this.arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "s3_bucket" {
  statement = {
    sid    = "DenyDeleteExceptFromSuperAdmin"
    effect = "Deny"

    principals = {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:DeleteBucket",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
    ]

    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}/*",
      "arn:aws:s3:::${local.s3_bucket_name}",
    ]

    condition = {
      test     = "StringNotLike"
      variable = "aws:userId"

      values = [
        "${data.aws_iam_role.super_admin.id}:*", #SuperAdminRoleId
      ]
    }
  }
}
