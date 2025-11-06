# IAM Users Deployment

This deployment manages IAM users and groups with flexible policy assignments.

## 📁 Structure

```
deployments/iam_users/
├── main.tf              # Calls iam_user module with config values
├── variables.tf         # Accepts values from ../../config/
├── outputs.tf           # Exposes user info and passwords
├── backend.tf           # S3 backend configuration
├── password_policy.tf   # AWS account password policy
└── providers.tf         # AWS provider setup
```

## 🎯 Flow

```
../../config/<env>/terraform.tfvars  (groups configuration)
              ↓
        variables.tf                 (accepts the groups)
              ↓
        main.tf                      (passes to module)
              ↓
    ../../modules/iam_user           (creates groups and users)
```

## 🚀 Usage

All commands are run from **this directory** (`deployments/iam_users/`).

### Deploy to DEV

```bash
cd deployments/iam_users/

# Initialize with dev backend
terraform init -backend-config=../../config/dev/backend.hcl

# Plan changes for dev
terraform plan -var-file=../../config/dev/terraform.tfvars

# Apply changes for dev
terraform apply -var-file=../../config/dev/terraform.tfvars
```

### Deploy to STAGING

```bash
cd deployments/iam_users/

# Switch to staging backend
terraform init -backend-config=../../config/staging/backend.hcl -reconfigure

# Plan and apply for staging
terraform plan -var-file=../../config/staging/terraform.tfvars
terraform apply -var-file=../../config/staging/terraform.tfvars
```

### Deploy to PROD

```bash
cd deployments/iam_users/

# Switch to prod backend
terraform init -backend-config=../../config/prod/backend.hcl -reconfigure

# Plan and apply for prod
terraform plan -var-file=../../config/prod/terraform.tfvars
terraform apply -var-file=../../config/prod/terraform.tfvars
```

## 💡 Using Environment Variable

```bash
cd deployments/iam_users/

# Set your target environment
export ENV=dev

# Use in commands
terraform init -backend-config=../../config/$ENV/backend.hcl
terraform plan -var-file=../../config/$ENV/terraform.tfvars
terraform apply -var-file=../../config/$ENV/terraform.tfvars
```

## 📝 What Each File Does

| File | Purpose |
|------|---------|
| `main.tf` | Calls the `iam_user` module from `../modules/iam_user` |
| `variables.tf` | Defines variables that config provides (user_names, policies) |
| `outputs.tf` | Exposes outputs from the module (users, passwords, SSM paths) |
| `backend.tf` | Configures S3 backend (partial - needs backend-config flag) |
| `password_policy.tf` | Sets AWS account-wide password policy |
| `providers.tf` | Configures AWS provider |

## 🔄 Workflow

1. **Choose environment**: `export ENV=dev`
2. **Initialize**: Point to the environment's backend config
3. **Plan**: Review what will be created using environment's variables
4. **Apply**: Deploy the infrastructure for that environment

Each environment is completely isolated with:
- Separate state files in S3
- Separate user lists
- Same infrastructure code (DRY principle)

