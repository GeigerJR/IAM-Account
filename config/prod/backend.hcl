# Backend configuration for PROD environment
bucket         = "project-terraform-state"
key            = "iam-account/prod/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "project-terraform-locks"
encrypt        = true

