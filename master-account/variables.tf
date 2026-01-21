variable "backup_account" {
  type        = string
  description = "Backup account id where centralised backups will be stored"
}

variable "isMpaEnabled" {
  type        = string
  description = "Whether to enable multi-party approval for backup"
  default = false
}
