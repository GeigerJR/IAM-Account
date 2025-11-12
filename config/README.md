### Purpose

The `config` directory holds **environment-specific configuration files**.  
These files define how different environments (e.g., dev, staging, prod) connect to the remote backend and apply infrastructure settings.

### Folder Structure

config
    dev
        backend.hcl
        terraform.tfvars
    staging
        backend.hcl
        terraform.tfvars
    prod
        backend.hcl
        terraform.tfvars

### Typical Contents

- backend.hcl – Points to the correct S3 bucket and DynamoDB table  
- terraform.tfvars – Defines environment variables like region, naming conventions, etc.

### Setup Steps

1. Navigate to the environment folder:

cd config/dev

2. Review and update `backend.hcl` and `terraform.tfvars` as needed.  
3. Repeat for `staging` and `prod` folders before running Terraform in `deployments`.

### Why This Matters

- Promotes **environment isolation** — each environment has its own configuration  
- Makes deployments **repeatable and predictable**  
- Allows **safe testing** before production rollout
