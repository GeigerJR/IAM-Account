# Backend configuration for DEV environment
bucket         = "project-terraform-state"
key            = "iam-account/dev/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "project-terraform-locks"
encrypt        = true

