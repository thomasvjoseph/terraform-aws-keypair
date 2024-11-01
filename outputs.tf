output "key_pair_name" {
  description = "The name of the generated key pair"
  value       = aws_key_pair.tf-key-pair.key_name
}

output "private_key_path" {
  description = "The path to the private key file"
  value       = local_file.tf-key.filename
}

output "private_key_value" {
  description = "The private key stored in Secrets Manager"
  value       = tls_private_key.rsa.private_key_pem
  sensitive   = true
}