# Variables are provided via config/<env>/terraform.tfvars

variable "group_name" {
  description = "Name of the IAM group to create"
  type        = string
}

variable "user_names" {
  description = "List of IAM usernames to create"
  type        = list(string)
}

variable "admin_policy_arn" {
  description = "ARN of the IAM policy to attach to the group"
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

