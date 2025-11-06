# Backend configuration for STAGING environment
bucket         = "project-terraform-state"
key            = "iam-account/staging/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "project-terraform-locks"
encrypt        = true

