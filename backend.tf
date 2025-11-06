terraform {
  backend "s3" {
    # Reference the shared S3 bucket created in backend/
    bucket = "project-terraform-state" # Must match backend/variables.tf bucket_name

    # Folder-based state separation within the bucket
    # Format: <project-name>/<environment>/terraform.tfstate
    key = "iam-account/dev/terraform.tfstate"

    region = "us-east-1"

    # Reference the shared DynamoDB table for state locking
    dynamodb_table = "project-terraform-locks" # Must match backend/variables.tf dynamodb_table

    # Encryption is handled by S3 bucket policy, but this adds an extra layer
    encrypt = true
  }
}

# For different environments, change the key:
# - Dev:     "iam-account/dev/terraform.tfstate"
# - Staging: "iam-account/staging/terraform.tfstate"
# - Prod:    "iam-account/prod/terraform.tfstate"
#
# Or use Terraform workspaces with dynamic keys:
# key = "iam-account/${terraform.workspace}/terraform.tfstate"