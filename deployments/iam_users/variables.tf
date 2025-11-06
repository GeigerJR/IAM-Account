# Variables are provided via config/<env>/terraform.tfvars

variable "groups" {
  description = "Map of IAM groups with their policies and users"
  type = map(object({
    policy_arn = string
    users      = list(string)
  }))
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

