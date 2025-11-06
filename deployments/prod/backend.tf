terraform {
  backend "s3" {
    bucket         = "iam-terraform-state-792560"
    key            = "iam-account/prod/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
