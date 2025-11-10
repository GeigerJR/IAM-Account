output "iam_user_names" {
  description = "Names of created IAM users"
  value       = [for user in module.iam_users : user.user_name]
}

output "iam_access_key_ids" {
  description = "Access key IDs for created IAM users"
  value       = { for user in module.iam_users : user.user_name => user.access_key_id }
  sensitive   = true
}

output "iam_secret_access_keys" {
  description = "Secret access keys for created IAM users"
  value       = { for user in module.iam_users : user.user_name => user.secret_access_key }
  sensitive   = true
}