output "secret_id" {
  description = "The ID of the secret"
  value       = aws_secretsmanager_secret_version.secretsmanager_version.secret_id
}