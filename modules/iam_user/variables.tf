# IAM Groups configuration
# Map of group names to their configuration (policy and users)
variable "groups" {
  description = "Map of IAM groups with their policies and users"
  type = map(object({
    policy_arn = string
    users      = list(string)
  }))

  # Example:
  # groups = {
  #   "Admins" = {
  #     policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  #     users      = ["John-Dev", "Mary-Dev"]
  #   }
  #   "PowerUsers" = {
  #     policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  #     users      = ["David-Dev"]
  #   }
  # }
}
