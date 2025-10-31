resource "aws_kms_key" "vault_kms" {
  description             = var.kms_description
  policy = data.aws_iam_policy_document.kms_policy.json
  tags = {
    "Name" = var.kms_name
  }
}