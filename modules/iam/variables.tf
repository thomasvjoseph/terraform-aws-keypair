variable "user_name" {
  description = "Name of the IAM user to create"
  type        = string
}

variable "path" {
  description = "Path for the IAM user"
  type        = string
  default     = "/"
}

variable "secretsmanager_name" {
  description = "Name of the Secrets Manager secret that will hold the IAM access keys"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the IAM user and the secret"
  type        = map(string)
  default     = {}
}
