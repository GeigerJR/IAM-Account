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
  region = "us-east-1"
}



module "iam_users" {
  source = "../../modules/iam_user"

  user_names = ["John", "Mary", "David"]
  admin_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
