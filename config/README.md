# Environment Configuration

All environment-specific configurations are housed in their respective folders.

## 📁 Structure

```
config/
├── dev/
│   ├── backend.hcl         # S3 backend configuration
│   └── terraform.tfvars    # All environment-specific variables
│                           # (users, policies, tags, etc.)
└── README.md
```

## 🎯 Philosophy

Each environment folder contains **everything** specific to that environment:
- Backend state configuration
- User lists (different users per environment)
- Policy settings
- Tags and metadata
- Any other environment-specific settings

## 🚀 Usage

### Initialize for an environment

```bash
# Using dev
terraform init -backend-config=config/dev/backend.hcl

# Using staging (when added)
terraform init -backend-config=config/staging/backend.hcl -reconfigure
```

### Plan changes

```bash
terraform plan -var-file=config/dev/terraform.tfvars
```

### Apply changes

```bash
terraform apply -var-file=config/dev/terraform.tfvars
```

## 💡 Using Environment Variable

```bash
# Set your environment
export ENV=dev

# Use in commands
terraform init -backend-config=config/$ENV/backend.hcl
terraform plan -var-file=config/$ENV/terraform.tfvars
terraform apply -var-file=config/$ENV/terraform.tfvars
```

## 📋 Example: Different Users Per Environment

**dev/terraform.tfvars:**
```hcl
user_names = ["John-Dev", "Mary-Dev"]
```

**staging/terraform.tfvars:**
```hcl
user_names = ["John-Staging", "Mary-Staging"]
```

**prod/terraform.tfvars:**
```hcl
user_names = ["John-Prod", "Mary-Prod"]
# Maybe use ReadOnlyAccess for some users in prod
```

## 🔄 Adding New Environments

To add staging or prod:

```bash
# Create the environment folder
mkdir -p config/staging

# Copy templates from dev
cp config/dev/backend.hcl config/staging/
cp config/dev/terraform.tfvars config/staging/

# Customize staging/backend.hcl - update the key:
# key = "iam-account/staging/terraform.tfstate"

# Customize staging/terraform.tfvars - update users, settings, etc:
# user_names = ["John-Staging", "Mary-Staging"]
```

## 📊 S3 State Organization

Your state files are organized by environment:

```
s3://project-terraform-state/
└── iam-account/
    ├── dev/terraform.tfstate       (config/dev/)
    ├── staging/terraform.tfstate   (config/staging/)
    └── prod/terraform.tfstate      (config/prod/)
```

## 🔐 Best Practice: Environment Isolation

Each environment is completely isolated:
- ✅ Separate state files
- ✅ Separate users (John-Dev vs John-Prod)
- ✅ Separate AWS resources
- ✅ No cross-contamination

You could even use:
- Different AWS accounts per environment
- Different AWS regions
- Different bucket names
- Different access policies
