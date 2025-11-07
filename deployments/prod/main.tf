terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "eu-central-1"
  
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_requesting_account_id = true
  
  s3_use_path_style = true

  endpoints {
    iam = "http://localhost:4566"
    s3 = "http://localhost:4566"
    ssm = "http://localhost:4566"
  }
}

module "iam_users" {
  source = "../../modules/iam_user"

  groups = var.groups
}
