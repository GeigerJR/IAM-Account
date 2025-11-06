terraform {
  # Backend configuration without hardcoded values
  # Environment-specific values provided via backend config files
  backend "s3" {
    # These values will be provided during terraform init
    # using: terraform init -backend-config=environments/<env>/backend.hcl
  }
}
