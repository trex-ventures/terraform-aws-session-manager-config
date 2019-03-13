module "session_manager_config" {
  source                   = "../"
  product_domain           = "tsi"
  environment              = "staging"
  s3_bucket_description    = "s3 bucket to store session manager logs"
  ssm_document_description = "ssm documents to hold preference to store session manager logs"
}
