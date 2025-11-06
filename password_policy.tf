# AWS IAM Account Password Policy
# This is an account-wide setting - only one policy per AWS account

resource "aws_iam_account_password_policy" "secure_policy" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 5
}

