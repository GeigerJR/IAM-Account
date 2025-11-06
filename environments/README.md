# Environment Configuration

Environment-specific configurations for Terraform. Currently configured for **dev** environment.

## 📁 Structure

```
environments/
└── dev/
    ├── backend.hcl         # S3 backend config
    └── terraform.tfvars    # Environment variables
```

## 🚀 Usage

### Initialize Terraform with dev backend

```bash
terraform init -backend-config=environments/dev/backend.hcl
```

### Plan changes

```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

### Apply changes

```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

## 🔄 Using Environment Variable (Optional)

```bash
# Set environment
export TF_ENV=dev

# Then use in commands
terraform init -backend-config=environments/$TF_ENV/backend.hcl
terraform plan -var-file=environments/$TF_ENV/terraform.tfvars
terraform apply -var-file=environments/$TF_ENV/terraform.tfvars
```

## 📊 State File Location

Your state will be stored at:
```
s3://project-terraform-state/iam-account/dev/terraform.tfstate
```

## 📝 Adding More Environments

When ready to add staging or prod:

```bash
# Create new environment
mkdir -p environments/staging
cp environments/dev/backend.hcl environments/staging/
cp environments/dev/terraform.tfvars environments/staging/

# Update key in staging/backend.hcl to:
# key = "iam-account/staging/terraform.tfstate"
```
