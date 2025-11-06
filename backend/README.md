# Terraform Backend Infrastructure (Bootstrap)

This directory contains the **bootstrap infrastructure** for Terraform remote state management. Run this **once** to create shared resources used by all your Terraform projects.

## 📦 What This Creates

### S3 Bucket
- Stores Terraform state files for all projects
- **Versioning enabled** - allows rollback to previous states
- **Encryption enabled** - AES256 server-side encryption
- **Public access blocked** - prevents accidental exposure
- **Lifecycle rules** - moves old versions to cheaper storage and expires after 90 days

### DynamoDB Table
- Provides state locking to prevent concurrent modifications
- **Pay-per-request billing** - only pay for what you use
- **Point-in-time recovery** - can restore table to any point in time

## ⚠️ Important Notes

- **Run this ONCE**: These resources are shared across all Terraform projects
- **Uses local state**: This bootstrap infrastructure uses local state (chicken-and-egg problem)
- **Keep the state file**: Backup the `terraform.tfstate` file created here
- **Update carefully**: Changes here affect ALL projects using this backend

## 🚀 Setup Instructions

### Step 1: Configure Variables

```bash
cd backend/

# Copy the example file
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your values
# IMPORTANT: bucket_name must be globally unique across ALL AWS accounts!
vim terraform.tfvars
```

### Step 2: Initialize and Apply

```bash
terraform init
terraform plan
terraform apply
```

### Step 3: Save the Outputs

```bash
# Note these values - you'll need them in other projects
terraform output

# Example output:
# bucket_name = "project-terraform-state"
# dynamodb_table_name = "project-terraform-locks"
```

### Step 4: Backup the State File ⚠️

```bash
# This is CRITICAL! Back up the local state file
cp terraform.tfstate terraform.tfstate.backup

# Store this backup somewhere safe:
# - Encrypted USB drive
# - Password manager
# - Secure cloud storage
# - Company secrets vault
```

## 📂 Usage in Other Projects

After creating these resources, reference them in your project's `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket         = "project-terraform-state"              # From backend outputs
    key            = "my-project/dev/terraform.tfstate"     # Unique per project/env
    region         = "us-east-1"
    dynamodb_table = "project-terraform-locks"              # From backend outputs
    encrypt        = true
  }
}
```

### Folder-Based State Separation

The `key` parameter creates a folder structure in S3:

```
s3://project-terraform-state/
├── iam-account/
│   ├── dev/terraform.tfstate
│   ├── staging/terraform.tfstate
│   └── prod/terraform.tfstate
├── network/
│   ├── dev/terraform.tfstate
│   └── prod/terraform.tfstate
├── databases/
│   └── prod/terraform.tfstate
└── applications/
    └── web-app/
        ├── dev/terraform.tfstate
        └── prod/terraform.tfstate
```

**Format**: `<project-name>/<environment>/terraform.tfstate`

### Dynamic Keys with Workspaces

Alternatively, use Terraform workspaces:

```hcl
terraform {
  backend "s3" {
    bucket         = "project-terraform-state"
    key            = "my-project/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "project-terraform-locks"
    encrypt        = true
  }
}
```

## 🔄 Updating Backend Infrastructure

If you need to modify these resources:

```bash
cd backend/
terraform plan
terraform apply
```

⚠️ Changes will affect all projects using this backend immediately.

## 🗑️ Destroying (Dangerous!)

Only destroy if you're decommissioning ALL projects:

```bash
# Step 1: Destroy all projects using this backend first!
# Step 2: Then destroy the backend
cd backend/
terraform destroy
```

**Warning**: This will delete all state files! Make backups first.

## 🐛 Troubleshooting

### Bucket name already exists
**Error**: `BucketAlreadyExists` or `BucketAlreadyOwnedByYou`  
**Solution**: S3 bucket names are globally unique. Choose a different name in `terraform.tfvars`.

### Access denied errors
**Error**: `AccessDenied` when creating resources  
**Solution**: Ensure your AWS credentials have permissions to create:
- S3 buckets
- DynamoDB tables
- IAM policies (if using bucket policies)

### State file lost
**Error**: Lost or corrupted `terraform.tfstate`  
**Solution**: 
1. Restore from backup
2. Or recreate infrastructure and import existing resources:
   ```bash
   terraform import aws_s3_bucket.terraform_state project-terraform-state
   terraform import aws_dynamodb_table.terraform_locks project-terraform-locks
   ```

## 💰 Cost Considerations

Expected monthly costs (typical usage):

| Resource | Cost |
|----------|------|
| S3 Storage | ~$0.023 per GB/month |
| S3 Requests | Minimal (mostly free tier) |
| DynamoDB | Pay-per-request (typically < $1/month) |
| **Total** | **< $5/month for typical usage** |

The lifecycle rules automatically:
- Move old versions to cheaper storage (STANDARD_IA) after 30 days
- Delete old versions after 90 days
- This reduces storage costs significantly

## 📚 References

- [Terraform S3 Backend](https://www.terraform.io/docs/language/settings/backends/s3.html)
- [AWS S3 Pricing](https://aws.amazon.com/s3/pricing/)
- [AWS DynamoDB Pricing](https://aws.amazon.com/dynamodb/pricing/)

