# DEV Environment Configuration
environment = "dev"

# IAM Group name for DEV
group_name = "DevOps-Dev"

# IAM Users for DEV environment
user_names = ["John-Dev", "Mary-Dev", "David-Dev"]

# Admin policy to attach to the group
admin_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

# You can add more dev-specific variables here
# tags = {
#   Environment = "dev"
#   Team        = "DevOps"
#   ManagedBy   = "Terraform"
# }
