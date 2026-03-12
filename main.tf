resource "aws_key_pair" "tf-key-pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_pair_name}.pem"
}

module "secretsmanager" {
  source              = "./modules/secretsmanager"
  count               = var.secretsmanager_name != "" ? 1 : 0
  secretsmanager_name = var.secretsmanager_name != "" ? var.secretsmanager_name : "${var.key_pair_name}-pem"
  description         = var.secrets_description
  secrets_value       = tls_private_key.rsa.private_key_pem
  tags                = var.iam_tags
}

# optional IAM user creation with access keys stored in Secrets Manager
module "iam_user" {
  source              = "./modules/iam"
  count               = var.iam_user_name != "" && var.iam_secrets_name != "" ? 1 : 0
  user_name           = var.iam_user_name
  secretsmanager_name = var.iam_secrets_name
  tags                = var.iam_tags
}