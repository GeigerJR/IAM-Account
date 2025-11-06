terraform {
  # Backend configuration provided via config/<env>/backend.hcl
  # Initialize with: terraform init -backend-config=config/<env>/backend.hcl
  backend "s3" {}
}
