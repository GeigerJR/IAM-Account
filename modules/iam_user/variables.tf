# IAM username to be created
variable "user_names" {
  description = "List of IAM usernames to create"
  type        = list(string)
}

# Policy ARN to attach to the user (default is AdministratorAccess)
variable "admin_policy_arn" {
  description = "ARN of the IAM policy to attach (e.g., AdministratorAccess)"
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}
