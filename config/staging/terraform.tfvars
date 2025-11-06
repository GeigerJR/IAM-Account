# STAGING Environment Configuration
environment = "staging"

# IAM Groups with their policies and users
groups = {
  "Admins-Staging" = {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    users      = ["John-Staging"]
  }

  "PowerUsers-Staging" = {
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    users      = ["Mary-Staging", "David-Staging"]
  }
}
