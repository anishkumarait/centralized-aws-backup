data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid = "Enable IAM User Permissions"

    actions = ["kms:*"]

    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid = "Allow access to backup account"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/backup.amazonaws.com/AWSServiceRoleForBackup",
        "arn:aws:iam::${var.backup_account}:role/aws-service-role/backup.amazonaws.com/AWSServiceRoleForBackup",
        aws_iam_role.backup_role.arn
      ]
    }
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow grant for backup"

    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]

    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/backup.amazonaws.com/AWSServiceRoleForBackup",
        "arn:aws:iam::${var.backup_account}:role/aws-service-role/backup.amazonaws.com/AWSServiceRoleForBackup",
        aws_iam_role.backup_role.arn
      ]
    }
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"

      values = [
        "true"
      ]
    }
  }
}

data "aws_iam_policy_document" "backup_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["backup.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

data "aws_iam_policy_document" "vault_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.backup_account}:root"]
    }

    actions = [
      "backup:CopyIntoBackupVault"
    ]

    resources = [aws_backup_vault.vault.arn]
  }
}