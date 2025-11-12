terraform {
  backend "s3" {
    # 🪣 S3 bucket to store Terraform state files
    bucket         = "project-terraform-state"   # <-- replace with your actual bucket name
    key            = "iam-account/terraform.tfstate"
    region         = "us-east-1"

    # 🔒 DynamoDB table for state locking
    dynamodb_table = "project-terraform-locks"   # <-- replace with your DynamoDB table name

    # ✅ Recommended best practice
    encrypt        = true
  }
}