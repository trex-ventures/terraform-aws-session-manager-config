# terraform-aws-session-manager-config
This terraform module creates configuration for session manager preferences or logging. 

This module creates the following resources
* [aws_s3_bucket](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html).
This s3 bucket will be used as location to store session manager activity
* [aws_ssm_document](https://www.terraform.io/docs/providers/aws/r/ssm_document.html)
This SSM document configures where to store the session manager activity.
* [aws_iam_policy](https://www.terraform.io/docs/providers/aws/r/aws_iam_policy.html).
This managed IAM policy grants access to EC2 instances to enable session manager capability and write logs to s3 bucket, Attach this policy to your ec2 instance IAM Role.


## Usage ##
Please see [examples](examples/main.tf) directory for examples how to use this module.

## Authors ##
Module managed by [Bernard Siahaan](https://github.com/siahaanbernard/)