variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "user_name" {
  description = "The name of the IAM user to create"
  type        = string
  default     = "john"
}

variable "admin_policy_arn" {
  description = "The IAM policy ARN to attach (default is AdministratorAccess)"
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}