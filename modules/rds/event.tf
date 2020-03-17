resource "aws_db_event_subscription" "rds_created" {
  name      = "rds-created-event-sub"
  sns_topic = aws_sns_topic.rds_created.arn

  source_type = "db-instance"
  // can't specify the source_id as our RDS instance because that creates a cycle
  // so have to subscribe to all instances

  event_categories = ["creation"]

  tags = merge(
    local.common_tags,
    map(
      "Name", "RDS Created Subscription"
    )
  )
}

