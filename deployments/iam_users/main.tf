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
  region = var.region
}

module "iam_users" {
  source = "../../modules/iam_user"

  groups = {
    "Admins" = {
      policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
      users       = ["John", "Mary"]
    }

    "PowerUsers" = {
      policy_arns = [
        "arn:aws:iam::aws:policy/PowerUserAccess",
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
      ]
      users = ["David"]
    }
  }
}