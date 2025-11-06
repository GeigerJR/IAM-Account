# DEV Environment Configuration
environment = "dev"

# IAM Groups with their policies and users
groups = {
  "Admins-Dev" = {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    users      = ["John-Dev", "Mary-Dev"]
  }

  "PowerUsers-Dev" = {
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    users      = ["David-Dev"]
  }

  # You can add more groups as needed:
  # "ReadOnly-Dev" = {
  #   policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  #   users      = ["Alice-Dev", "Bob-Dev"]
  # }
}
