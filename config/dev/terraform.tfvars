# DEV Environment Configuration
environment = "dev"

# IAM Groups with their policies, roles, and users
groups = {
  "Admins-Dev" = {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    role       = "Administrator"
    users      = ["John-Dev", "Mary-Dev"]
  }

  "PowerUsers-Dev" = {
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    role       = "Power User"
    users      = ["David-Dev"]
  }

  # You can add more groups as needed:
  # "ReadOnly-Dev" = {
  #   policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  #   role       = "Read Only User"
  #   users      = ["Alice-Dev", "Bob-Dev"]
  # }
}
