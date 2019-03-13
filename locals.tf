locals {
  s3_bucket_name    = "default-ssm-logs-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  iam_policy_name   = "EC2PolicyToEnableSSM"
  ssm_document_name = "SSM-SessionManagerRunShell"
}
