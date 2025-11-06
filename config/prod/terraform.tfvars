# PROD Environment Configuration
environment = "prod"

# IAM Group name for PROD
group_name = "DevOps-Prod"

# IAM Users for PROD environment
user_names = ["John-Prod", "Mary-Prod", "David-Prod"]

# Admin policy to attach to the group
admin_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

# Production-specific settings
# tags = {
#   Environment = "prod"
#   Team        = "DevOps"
#   ManagedBy   = "Terraform"
#   CriticalSystem = "true"
# }

