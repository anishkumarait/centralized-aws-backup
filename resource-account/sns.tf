resource "aws_sns_topic" "backup_alerts" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "backup_subscription" {
  topic_arn = aws_sns_topic.backup_alerts.arn
  protocol  = "email"
  endpoint  = var.email_endpoint
}
