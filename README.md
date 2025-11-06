# 🚀 AWS IAM User Management with Terraform

Automated IAM user creation with multi-environment support, using a clean modular structure.

---

## 📁 Project Structure

```
IAM-Account/
├── backend/              # Bootstrap infrastructure (run once)
│   ├── main.tf          # Creates S3 bucket + DynamoDB table
│   ├── variables.tf
│   └── outputs.tf
│
├── modules/              # Reusable Terraform modules
│   └── iam_user/        # IAM user creation module
│       ├── main.tf      # Handles multiple users with for_each
│       ├── variables.tf
│       ├── outputs.tf
│       └── versions.tf
│
├── deployments/          # Deployment orchestration
│   ├── main.tf          # Calls iam_user module
│   ├── variables.tf     # Accepts config values
│   ├── outputs.tf       # Exposes results
│   ├── backend.tf       # S3 backend config
│   ├── password_policy.tf
│   └── providers.tf
│
└── config/               # Environment-specific configurations
    ├── dev/
    │   ├── backend.hcl   # Dev state location
    │   └── terraform.tfvars  # Dev users: John-Dev, Mary-Dev
    ├── staging/
    │   ├── backend.hcl
    │   └── terraform.tfvars  # Staging users
    └── prod/
        ├── backend.hcl
        └── terraform.tfvars  # Prod users
```

---

## 🎯 Architecture Flow

```
config/dev/terraform.tfvars
    user_names = ["John-Dev", "Mary-Dev", "David-Dev"]
              ↓
    deployments/variables.tf
    (accepts the list)
              ↓
    deployments/main.tf
    (passes to module)
              ↓
    modules/iam_user
    (for_each creates each user)
```

---

## 🚀 Quick Start

### Step 1: Bootstrap Backend Infrastructure (One-Time)

```bash
cd backend/

# Configure backend settings
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars  # Set your unique bucket name

# Create S3 + DynamoDB
terraform init
terraform apply

# IMPORTANT: Backup the state file
cp terraform.tfstate terraform.tfstate.backup

cd ..
```

See `backend/README.md` for detailed instructions.

### Step 2: Deploy to an Environment

All deployments run from the `deployments/` directory:

```bash
cd deployments/

# Set target environment
export ENV=dev

# Initialize with environment backend
terraform init -backend-config=../config/$ENV/backend.hcl

# Plan changes
terraform plan -var-file=../config/$ENV/terraform.tfvars

# Apply changes
terraform apply -var-file=../config/$ENV/terraform.tfvars
```

### Step 3: Retrieve User Passwords

```bash
cd deployments/

# View all user names
terraform output iam_user_names

# View SSM parameter paths
terraform output ssm_parameter_paths

# Get a specific user's password from SSM
aws ssm get-parameter \
  --name "/iam/John-Dev/temp_password" \
  --with-decryption \
  --query "Parameter.Value" \
  --output text
```

---

## 🌍 Environment Management

### Deploy to Different Environments

**Dev:**
```bash
cd deployments/
terraform init -backend-config=../config/dev/backend.hcl
terraform apply -var-file=../config/dev/terraform.tfvars
```

**Staging:**
```bash
cd deployments/
terraform init -backend-config=../config/staging/backend.hcl -reconfigure
terraform apply -var-file=../config/staging/terraform.tfvars
```

**Prod:**
```bash
cd deployments/
terraform init -backend-config=../config/prod/backend.hcl -reconfigure
terraform apply -var-file=../config/prod/terraform.tfvars
```

### Environment Isolation

Each environment is **completely isolated**:

| Environment | Users | State Location |
|------------|-------|----------------|
| **dev** | John-Dev, Mary-Dev, David-Dev | `s3://.../iam-account/dev/terraform.tfstate` |
| **staging** | John-Staging, Mary-Staging, David-Staging | `s3://.../iam-account/staging/terraform.tfstate` |
| **prod** | John-Prod, Mary-Prod, David-Prod | `s3://.../iam-account/prod/terraform.tfstate` |

---

## ⚙️ What Gets Created

### For Each User
- ✅ IAM user account
- ✅ Random secure password (16 characters)
- ✅ Login profile with forced password reset
- ✅ Policy attachment (default: AdministratorAccess)
- ✅ Password stored in SSM Parameter Store (encrypted)

### Account-Wide
- ✅ Password policy (14+ chars, complexity requirements)
- ✅ 90-day max password age
- ✅ Password reuse prevention

---

## 🔐 Security Features

1. **Random Passwords**: 16-character passwords with special characters
2. **SSM Parameter Store**: Passwords stored as SecureString (encrypted at rest)
3. **Force Password Reset**: Users must change password on first login
4. **Strong Password Policy**: Account-wide secure password requirements
5. **S3 Encryption**: State files encrypted at rest (AES256)
6. **Public Access Block**: S3 bucket protected from public access
7. **State Locking**: DynamoDB prevents concurrent modifications
8. **Versioning**: S3 versioning enabled for state file recovery
9. **Lifecycle Rules**: Old state versions automatically managed

---

## 📝 Customizing Environments

Edit `config/<env>/terraform.tfvars` to customize each environment:

```hcl
# config/dev/terraform.tfvars
environment = "dev"

# Different users per environment
user_names = ["John-Dev", "Mary-Dev"]

# Can use different policies per environment
admin_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

# Add more environment-specific settings
# tags = { Environment = "dev", Team = "DevOps" }
```

---

## 🔄 Common Operations

### Add a New User to Dev

1. Edit `config/dev/terraform.tfvars`:
   ```hcl
   user_names = ["John-Dev", "Mary-Dev", "David-Dev", "Alice-Dev"]
   ```

2. Apply changes:
   ```bash
   cd deployments/
   terraform apply -var-file=../config/dev/terraform.tfvars
   ```

### Remove a User

1. Remove from `config/<env>/terraform.tfvars`
2. Run `terraform apply`

**Note**: Module uses `force_destroy = true`, so users can be deleted even if they have resources.

### Switch Environments

```bash
cd deployments/

# From dev to staging
terraform init -backend-config=../config/staging/backend.hcl -reconfigure
terraform plan -var-file=../config/staging/terraform.tfvars
```

The `-reconfigure` flag tells Terraform to switch backends.

---

## 🧹 Cleanup

### Destroy an Environment

```bash
cd deployments/
terraform destroy -var-file=../config/dev/terraform.tfvars
```

### Destroy Backend (⚠️ Dangerous)

Only do this if decommissioning ALL environments:

```bash
cd backend/
terraform destroy
```

**Warning**: This deletes all state files! Back up first.

---

## 📊 Outputs

| Output | Description |
|--------|-------------|
| `iam_user_names` | List of created user names |
| `iam_user_temp_passwords` | Temporary passwords (sensitive) |
| `ssm_parameter_paths` | SSM paths for password retrieval |

---

## 🐛 Troubleshooting

### Backend initialization fails
- Ensure S3 bucket and DynamoDB table exist (run `backend/` first)
- Check bucket/table names in `config/<env>/backend.hcl` match backend outputs

### Access denied errors
- Verify AWS credentials have IAM permissions
- Check that your user can create IAM users, groups, and policies

### Wrong environment
Always run from `deployments/` directory and verify backend config:
```bash
cat .terraform/terraform.tfstate | grep '"address"'
```

### State locking errors
Someone else might be running Terraform. Wait for them to finish, or if stuck:
```bash
terraform force-unlock <LOCK_ID>
```

---

## 📚 Documentation

- `backend/README.md` - Backend bootstrap instructions
- `deployments/README.md` - Deployment workflow guide
- `config/README.md` - Environment configuration guide
- `modules/iam_user/` - Module documentation

---

## 🎓 Best Practices

1. **Always use environment variables**: `export ENV=dev` for consistency
2. **Review plans before applying**: Always run `terraform plan` first
3. **Use separate AWS accounts for prod**: Additional isolation
4. **Require approvals for prod**: Add manual approval in CI/CD
5. **Backup state files**: Especially the bootstrap backend state
6. **Use meaningful user names**: Include environment suffix (e.g., John-Dev)
7. **Rotate passwords regularly**: Consider AWS Secrets Manager for automation
8. **Monitor IAM activity**: Enable CloudTrail for audit logs

---

## 📝 License

This project is for educational and internal use.
