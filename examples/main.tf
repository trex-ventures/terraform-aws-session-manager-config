module "session_manager_config" {
  source      = "../"
  product     = "tsi"
  environment = "staging"
  admin_role_names = [
    "AWSReservedSSO_SuperAdmin_6ee1abab3c49d055",
    "AWSReservedSSO_LendingAdmin_b57aea22c2e2b90a"
  ]
}

provider "aws" {
  region = "ap-southeast-1"
}
