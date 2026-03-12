output "user_arn" {
  description = "ARN of the IAM user"
  value       = aws_iam_user.this.arn
}

output "access_key_id" {
  description = "The generated access key ID"
  value       = aws_iam_access_key.this.id
  sensitive   = true
}

output "secret_access_key" {
  description = "The generated secret access key"
  value       = aws_iam_access_key.this.secret
  sensitive   = true
}

output "credentials_secret_id" {
  description = "The ID of the Secrets Manager secret containing the credentials"
  value       = aws_secretsmanager_secret.iam_credentials.id
}

output "credentials_secret_arn" {
  description = "ARN of the credentials secret"
  value       = aws_secretsmanager_secret.iam_credentials.arn
}
