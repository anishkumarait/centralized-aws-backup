variable "vault_name" {
  type        = string
  description = "Name for centralised AWS Backup vault"
}

variable "kms_description" {
  type        = string
  description = "Description for KMS key"
}

variable "kms_name" {
  type        = string
  description = "Name for KMS key to encrypt AWS Backup vault"
}

variable "resource_account" {
  type        = string
  description = "Account Id where your resources are present for backup"
}
