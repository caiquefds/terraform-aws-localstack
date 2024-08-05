provider "aws" {

  region  = "us-east-1"
  profile = "localstack"

  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3  = "http://localhost:4566"
    sns = "http://localhost:4566"
    sqs = "http://localhost:4566"

  }


}

resource "aws_s3_bucket" "my_bucket_1" {
  bucket = "my-bucket-1"

}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.my_bucket_1.id

  topic {
    topic_arn = aws_sns_topic.my_topic_1.arn
    events    = ["s3:ObjectCreated:*"]
  }
}


resource "aws_sns_topic" "my_topic_1" {
  name = "my-topic-2"
}

resource "aws_sns_topic_subscription" "my_queue_1_subscription" {
  topic_arn = aws_sns_topic.my_topic_1.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.my_queue_1.arn
}

resource "aws_sns_topic_subscription" "my_queue_2_subscription" {
  topic_arn = aws_sns_topic.my_topic_1.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.my_queue_2.arn
}


resource "aws_sqs_queue" "my_queue_1" {
  name = "my-queue-1"
}

resource "aws_sqs_queue" "my_queue_2" {
  name = "my-queue-2"
}