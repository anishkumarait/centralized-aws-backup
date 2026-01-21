resource "aws_organizations_delegated_administrator" "aws_backup" {
  account_id        = var.backup_account
  service_principal = "backup.amazonaws.com"
}

resource "aws_backup_global_settings" "backup_features" {
  global_settings = {
    isCrossAccountBackupEnabled = "true"
    isDelegatedAdministratorEnabled = "true"
    isMpaEnabled = var.isMpaEnabled
  }
}
