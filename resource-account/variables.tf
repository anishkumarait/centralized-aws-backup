variable "vault_name" {
  type        = string
  description = "Name for resource account AWS Backup vault"
}

variable "kms_description" {
  type        = string
  description = "Description for KMS key"
}

variable "kms_name" {
  type        = string
  description = "Name for KMS key to encrypt AWS Backup vault"
}

variable "backup_account" {
  type        = string
  description = "Account Id of centralised backup account"
}

variable "sns_topic_name" {
  type        = string
  description = "Name for SNS topic to send alerts"
}

variable "email_endpoint" {
  type        = string
  description = "Email address for SNS topic subscription"
}

variable "backup_role_name" {
  type        = string
  description = "IAM role name for Backup service"
}

variable "plan_name" {
  type        = string
  description = "Backup plan name"
}

variable "rule_name" {
  type        = string
  description = "Backup rule name"
}

variable "cron_expression" {
  type        = string
  description = "Cron expression to define when Backup job will be initatited"
}

variable "delete_backup" {
  type        = number
  description = "Number of days after recovery point will be deleted from resource account"
}

variable "centralised_vault_arn" {
  type        = string
  description = "ARN of Backup vault in centralised backup account"
}

variable "dcentralised_delete_backup" {
  type        = number
  description = "Number of days after recovery point will be deleted from centralised backup account"
}

variable "selection_name" {
  type        = string
  description = "Backup selction name"
}

variable "selection_tag_key" {
  type        = string
  description = "Tag's key for resources for backup selection"
}

variable "selection_tag_value" {
  type        = string
  description = "Tag's value for resources for backup selection"
}
