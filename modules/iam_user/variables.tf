variable "groups" {
  description = "Map of IAM groups with users and lists of policy ARNs"
  type = map(object({
    policy_arns = list(string)
    users       = list(string)
  }))
}