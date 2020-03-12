resource "aws_sns_topic" "rds_created" {
  name = "rds-created-event"

  tags = merge(
    local.common_tags,
    map(
      "Name", "RDS Created"
    )
  )
}

resource "aws_db_event_subscription" "rds_created" {
  name      = "rds-created-event-sub"
  sns_topic = aws_sns_topic.rds_created.arn

  source_type = "db-instance"
#  source_ids  = [aws_db_instance.rds_mysql.id]

  event_categories = ["creation"]

  tags = merge(
    local.common_tags,
    map(
      "Name", "RDS Created Subscription"
    )
  )
}

