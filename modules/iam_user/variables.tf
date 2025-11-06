variable "groups" {
  description = "Map of IAM groups with their policies, roles, and users"
  type = map(object({
    policy_arn = string
    role       = string
    users      = list(string)
  }))
}
