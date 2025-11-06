# STAGING Environment Configuration
environment = "staging"

# IAM Group name for STAGING
group_name = "DevOps-Staging"

# IAM Users for STAGING environment
user_names = ["John-Staging", "Mary-Staging", "David-Staging"]

# Admin policy to attach to the group
admin_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

# Staging-specific settings
# tags = {
#   Environment = "staging"
#   Team        = "DevOps"
#   ManagedBy   = "Terraform"
# }

