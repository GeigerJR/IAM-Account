variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile name to use"
  type        = string
  default     = "default"
}

variable "user_name" {
  description = "The name of the IAM user to create"
  type        = string
  default     = "John-Admin"
}