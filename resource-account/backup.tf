resource "aws_backup_vault" "vault" {
  name        = var.vault_name
  kms_key_arn = aws_kms_key.vault_kms.arn
}

resource "aws_backup_vault_policy" "vault" {
  backup_vault_name = aws_backup_vault.vault.name
  policy            = data.aws_iam_policy_document.vault_policy.json
}

resource "aws_backup_vault_notifications" "vault" {
  backup_vault_name   = aws_backup_vault.vault.name
  sns_topic_arn       = aws_sns_topic.backup_alerts.arn
  backup_vault_events = ["BACKUP_JOB_FAILED", "COPY_JOB_FAILED"]
}

resource "aws_backup_plan" "plan" {
  name = var.plan_name

  rule {
    rule_name         = var.rule_name
    target_vault_name = aws_backup_vault.vault.name
    schedule          = var.cron_expression

    lifecycle {
      delete_after = var.delete_backup
    }

    copy_action {
      destination_vault_arn = var.centralised_vault_arn

      lifecycle {
        delete_after = var.dcentralised_delete_backup
      }
    }
  }
}

resource "aws_backup_selection" "selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = var.selection_name
  plan_id      = aws_backup_plan.plan.id
   selection_tag {
    type  = "STRINGEQUALS"
    key   = var.selection_tag_key
    value = var.selection_tag_value
  }
}
