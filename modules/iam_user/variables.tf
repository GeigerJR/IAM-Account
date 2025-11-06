# IAM Groups configuration
# Map of group names to their configuration (policy, role, and users)
variable "groups" {
  description = "Map of IAM groups with their policies, roles, and users"
  type = map(object({
    policy_arn = string
    role       = string
    users      = list(string)
  }))

  # Example:
  # groups = {
  #   "Admins" = {
  #     policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  #     role       = "Administrator"
  #     users      = ["John-Dev", "Mary-Dev"]
  #   }
  #   "PowerUsers" = {
  #     policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  #     role       = "Power User"
  #     users      = ["David-Dev"]
  #   }
  # }
}
