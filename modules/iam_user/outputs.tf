output "user_names" {
  value = [for user in aws_iam_user.user : user.name]
}

output "user_temp_passwords" {
  value = { for k, v in random_password.temp_password : k => v.result }
  sensitive = true
}
