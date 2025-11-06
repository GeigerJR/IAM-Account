# Backend Bootstrap

Creates S3 bucket and DynamoDB table for Terraform state management. Run once.

## Setup

```bash
cd backend/

# Edit terraform.tfvars if needed

# Create resources
terraform init
terraform apply
```

## What Gets Created

- S3 bucket: `iam-terraform-state-8472910`
- DynamoDB table: `terraform-state-locks`

State file structure:
```
s3://iam-terraform-state-8472910/
└── iam-account/
    ├── dev/terraform.tfstate
    └── prod/terraform.tfstate
```

