resource "aws_iam_role" "backup_role" {
  name = var.backup_role_name

  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json
}

resource "aws_iam_role_policy_attachments_exclusive" "backup_role" {
  role_name   = aws_iam_role.backup_role.name
  policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"]
}
