# PROD Environment Configuration
environment = "prod"

# IAM Groups with their policies, roles, and users
groups = {
  "Admins-Prod" = {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    role       = "Administrator"
    users      = ["John-Prod", "Mary-Prod"]
  }

  "PowerUsers-Prod" = {
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    role       = "Power User"
    users      = ["David-Prod"]
  }

  # Production might have additional groups with restricted access
  # "ReadOnly-Prod" = {
  #   policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  #   role       = "Auditor"
  #   users      = ["Auditor-Prod"]
  # }
}
