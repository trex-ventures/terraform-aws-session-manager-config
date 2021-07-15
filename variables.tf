variable "s3_bucket_prefix" {
  default     = ""
  description = "(Optional) To write output to a sub-dir, enter a sub-dir name."
}

variable "product" {
  description = "product domain who owns this SSM Session Manager Configuration"
  type        = string
}

variable "environment" {
  description = "environment where this infrastructure reside."
  type        = string
}

variable "s3_bucket_description" {
  description = "description for this bucket."
  type        = string
  default     = "s3 bucket to store SSM session manager logs"
}

variable "session_manager_document_name" {
  default     = "SSM-SessionManagerRunShell"
  type        = string
  description = "The name of SSM document for session manager, this default name is the one allowed by AWS"
}

variable "ssm_document_description" {
  description = "description for ssm document"
  type        = string
  default     = "document to hold regional session manager preferences"
}

variable "s3_enable_versioning" {
  description = "Enable versioning for this bucket"
  default     = "true"
  type        = string
}

variable "s3_sse_algorithm" {
  description = "Encryption algorithm used for this bucket"
  default     = "AES256"
  type        = string
}

variable "admin_role_names" {
  description = "List of Administrator role names"
  type        = list(string)
  default = [
    "SuperAdmin",
  ]
}
