output "user_name" {
  description = "The name of the created IAM user"
  value       = aws_iam_user.user.name
}

output "access_key_id" {
  description = "Access key ID for the IAM user"
  value       = try(aws_iam_access_key.user_key.id, null)
  sensitive   = true
}

output "secret_access_key" {
  description = "Secret access key for the IAM user"
  value       = try(aws_iam_access_key.user_key.secret, null)
  sensitive   = true
}
