variable "key_pair_name" {
  description = "The name of the key pair"
}

variable "rsa_bits" {
  description = "The number of bits for RSA key generation"
  default     = 4096
}

variable "secretsmanager_name" {
  description = "Name of the Secrets Manager secret for storing the PEM file"
  type        = string
  default     = ""
}

variable "secrets_description" {
  description = "Description for the SSH key secret"
  type        = string
  default     = "SSH private key stored by Terraform"
}

variable "iam_user_name" {
  description = "Username for the IAM user to create"
  type        = string
  default     = ""
}

variable "iam_secrets_name" {
  description = "Name of the Secrets Manager secret for storing IAM credentials"
  type        = string
  default     = ""
}

variable "iam_tags" {
  description = "Tags to apply to IAM user and secret"
  type        = map(string)
  default     = {}
}
