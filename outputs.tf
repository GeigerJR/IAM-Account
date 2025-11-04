output "john_iam_user_name" {
  description = "The name of the created IAM user"
  value       = module.john_iam_user.user_name
}

output "john_access_key_id" {
  description = "Access key ID for John"
  value       = module.john_iam_user.access_key_id
  sensitive   = true
}

output "john_secret_access_key" {
  description = "Secret access key for John"
  value       = module.john_iam_user.secret_access_key
  sensitive   = true
}