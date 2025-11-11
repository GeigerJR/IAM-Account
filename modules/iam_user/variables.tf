variable "groups" {
  description = "Map of IAM groups, their users, and attached policies"
  type = map(object({
    policy_arn = string
    users      = list(string)
  }))
}