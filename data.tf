data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

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
    sid    = "AllowEC2InstancesToGetBucketEcnryption"
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
    ]

    resources = ["${aws_s3_bucket.this.arn}"]
  }
}
