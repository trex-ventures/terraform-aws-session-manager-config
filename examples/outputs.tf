output "s3_bucket_name" {
  value       = "${module.session_manager_config.s3_bucket_name}"
  description = "the name of s3 bucket"
}

output "iam_policy_name" {
  value       = "${module.session_manager_config.iam_policy_name}"
  description = "the name of iam policy for allowing session manager access"
}

output "ssm_document_name" {
  value       = "${module.session_manager_config.ssm_document_name}"
  description = "the name of ssm document for session manager preferences"
}
