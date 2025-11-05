# backend/variables.tf

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "my-terraform-state-bucket"
}

variable "dynamodb_table" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-lock"
}

variable "environment" {
  description = "Environment name (e.g., dev, stage, prod)"
  type        = string
  default     = "dev"
}
