output "key_pair_name" {
  description = "The name of the generated key pair"
  value       = aws_key_pair.tf-key-pair.key_name
}

output "private_key_path" {
  description = "The path to the private key file"
  value       = local_file.tf-key.filename
}

output "private_key_value" {
  description = "The raw private key generated locally (sensitive)"
  value       = tls_private_key.rsa.private_key_pem
  sensitive   = true
}

output "ssh_secret_id" {
  description = "ID of the Secrets Manager secret holding the SSH private key"
  value       = length(module.secretsmanager) > 0 ? module.secretsmanager[0].secret_id : ""
}

output "ssh_secret_arn" {
  description = "ARN of the SSH key secret"
  value       = length(module.secretsmanager) > 0 ? module.secretsmanager[0].secret_arn : ""
}

output "iam_user_arn" {
  description = "ARN of the created IAM user (if any)"
  value       = length(module.iam_user) > 0 ? module.iam_user[0].user_arn : ""
}

output "iam_credentials_secret_id" {
  description = "ID of the Secrets Manager secret containing the IAM credentials"
  value       = length(module.iam_user) > 0 ? module.iam_user[0].credentials_secret_id : ""
}
