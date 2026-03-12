resource "aws_iam_user" "this" {
  name = var.user_name
  path = var.path
  tags = var.tags
}

# grant SecretsManager read/write to the user
resource "aws_iam_user_policy" "secrets_rw" {
  name   = "${var.user_name}-secretsmanager"
  user   = aws_iam_user.this.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "secretsmanager:CreateSecret",
          "secretsmanager:PutSecretValue",
          "secretsmanager:GetSecretValue",
          "secretsmanager:UpdateSecret",
          "secretsmanager:DeleteSecret",
          "secretsmanager:ListSecrets",
          "secretsmanager:ListSecretVersionIds"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_secretsmanager_secret" "iam_credentials" {
  name        = var.secretsmanager_name
  description = "Access keys for IAM user ${aws_iam_user.this.name}"
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "iam_credentials_version" {
  secret_id     = aws_secretsmanager_secret.iam_credentials.id
  secret_string = jsonencode({
    access_key_id     = aws_iam_access_key.this.id
    secret_access_key = aws_iam_access_key.this.secret
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}
