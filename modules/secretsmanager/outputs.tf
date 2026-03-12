output "secret_id" {
  description = "The ID of the secret (same as aws_secretsmanager_secret.id)"
  value       = aws_secretsmanager_secret_version.secretsmanager_version.secret_id
}

output "secret_arn" {
  description = "The ARN of the secret"
  value       = aws_secretsmanager_secret.secretsmanager.arn
}

output "version_id" {
  description = "The version ID for the stored secret string"
  value       = aws_secretsmanager_secret_version.secretsmanager_version.version_id
}