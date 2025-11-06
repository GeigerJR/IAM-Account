environment = "prod"

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
}
