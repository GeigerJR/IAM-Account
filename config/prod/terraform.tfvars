# PROD Environment Configuration
environment = "prod"

# IAM Groups with their policies and users
groups = {
  "Admins-Prod" = {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    users      = ["John-Prod", "Mary-Prod"]
  }

  "PowerUsers-Prod" = {
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    users      = ["David-Prod"]
  }

  # Production might have additional groups with restricted access
  # "ReadOnly-Prod" = {
  #   policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  #   users      = ["Auditor-Prod"]
  # }
}
