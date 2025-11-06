# IAM Group name
variable "group_name" {
  description = "Name of the IAM group to create"
  type        = string
}

# IAM usernames to be created
variable "user_names" {
  description = "List of IAM usernames to create"
  type        = list(string)
}

# Policy ARN to attach to the group (default is AdministratorAccess)
variable "admin_policy_arn" {
  description = "ARN of the IAM policy to attach to the group (e.g., AdministratorAccess)"
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}
