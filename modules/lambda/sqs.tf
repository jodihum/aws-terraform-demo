resource "aws_sqs_queue" "task_queue" {
  name = local.lambda_name

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter_queue.arn
    maxReceiveCount     = 5
  })
  
  tags = local.common_tags
}

resource "aws_sqs_queue" "deadletter_queue" {
  name = "${local.lambda_name}-dlq"

  tags = local.common_tags
}

resource "aws_lambda_event_source_mapping" "queue_input_emitter" {
  event_source_arn = aws_sqs_queue.task_queue.arn
  function_name    = aws_lambda_function.setup_database_schema.arn
  batch_size       = 5 
}

resource "aws_sns_topic_subscription" "database_created" {
  topic_arn = var.sns_topic
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.task_queue.arn
}
