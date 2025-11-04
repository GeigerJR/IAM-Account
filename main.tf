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

resource "aws_iam_user" "example" {
  name = "phillip-test-user"
}


# Call the IAM user module
module "john_iam_user" {
  source    = "./modules/iam_user"
  user_name = var.user_name
}
