variable "secretsmanager_name" {
  description = "The name of the secret manager"
  type        = string
}

variable "description" {
  description = "The description of the secret manager"
  type        = string
  default     = "Managed by Terraform"
}

variable "secrets_value" {
  description = "The value of the secret"
  type        = string
}