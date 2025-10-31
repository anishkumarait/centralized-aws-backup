resource "aws_backup_vault" "vault" {
  name        = var.vault_name
  kms_key_arn = aws_kms_key.vault_kms.arn
}

resource "aws_backup_vault_policy" "vault" {
  backup_vault_name = aws_backup_vault.vault.name
  policy            = data.aws_iam_policy_document.vault_policy.json
}
