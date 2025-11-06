environment = "staging"

groups = {
  "Admins-Staging" = {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    role       = "Administrator"
    users      = ["John-Staging"]
  }

  "PowerUsers-Staging" = {
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    role       = "Power User"
    users      = ["Mary-Staging", "David-Staging"]
  }
}
