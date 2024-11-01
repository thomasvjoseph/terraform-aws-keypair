resource "aws_secretsmanager_secret" "secretsmanager" {
  name        = var.secretsmanager_name
  description = var.description
}

resource "aws_secretsmanager_secret_version" "secretsmanager_version" {
  secret_id     = aws_secretsmanager_secret.secretsmanager.id
  secret_string = var.secrets_value
}