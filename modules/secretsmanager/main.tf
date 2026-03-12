resource "aws_secretsmanager_secret" "secretsmanager" {
  name        = var.secretsmanager_name
  description = var.description
  tags        = var.tags

  # optional customer-managed KMS key
  kms_key_id = var.kms_key_id
}

resource "aws_secretsmanager_secret_version" "secretsmanager_version" {
  secret_id     = aws_secretsmanager_secret.secretsmanager.id
  secret_string = var.secrets_value

  lifecycle {
    # avoid accidental disclosure via plan
    ignore_changes = [secret_string]
  }
}