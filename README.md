# AWS IAM User Management with Terraform

Automated IAM user creation with multi-environment support.

## Project Structure

```
IAM-Account/
├── backend/              # S3 bucket + DynamoDB table (run once)
├── modules/iam_user/     # Reusable IAM user module
├── deployments/iam_users/ # IAM deployment orchestration
└── config/               # Environment-specific configs
    ├── dev/
    ├── staging/
    └── prod/
```

## Setup

### 1. Bootstrap Backend (One-Time)

```bash
cd backend/
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your bucket name
terraform init
terraform apply
cd ..
```

### 2. Deploy to Environment

```bash
cd deployments/iam_users/

# Initialize with environment backend
terraform init -backend-config=../../config/dev/backend.hcl

# Apply changes
terraform apply -var-file=../../config/dev/terraform.tfvars
```

### 3. Retrieve Passwords

```bash
# View outputs
terraform output iam_user_names

# Get password from SSM
aws ssm get-parameter \
  --name "/iam/dev/John-Dev/temp_password" \
  --with-decryption \
  --query "Parameter.Value" \
  --output text
```

## Environment Management

Switch environments by changing backend and tfvars:

```bash
cd deployments/iam_users/

# Dev
terraform init -backend-config=../../config/dev/backend.hcl
terraform apply -var-file=../../config/dev/terraform.tfvars

# Staging
terraform init -backend-config=../../config/staging/backend.hcl -reconfigure
terraform apply -var-file=../../config/staging/terraform.tfvars

# Prod
terraform init -backend-config=../../config/prod/backend.hcl -reconfigure
terraform apply -var-file=../../config/prod/terraform.tfvars
```

## Configuration

Edit `config/<env>/terraform.tfvars`:

```hcl
environment = "dev"

groups = {
  "Admins" = {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    role       = "Administrator"
    users      = ["John-Dev", "Mary-Dev"]
  }
  "PowerUsers" = {
    policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    role       = "Power User"
    users      = ["David-Dev"]
  }
}
```

## What Gets Created

- IAM users with login profiles
- IAM groups with policy attachments
- Random 16-character passwords
- SSM parameters (encrypted)
- Account password policy

## Security Features

- S3 state encryption and versioning
- DynamoDB state locking
- SSM SecureString for passwords
- Forced password reset on first login
- Public access block on S3
