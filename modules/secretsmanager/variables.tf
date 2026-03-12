variable "secretsmanager_name" {
  description = "The name of the secret in Secrets Manager"
  type        = string
}

variable "description" {
  description = "The description of the secret"
  type        = string
  default     = "Managed by Terraform"
}

variable "secrets_value" {
  description = "The value of the secret to store (e.g. private key PEM)"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to assign to the secret"
  type        = map(string)
  default     = {}
}

variable "kms_key_id" {
  description = "Optional KMS key ID to encrypt the secret"
  type        = string
  default     = null
}