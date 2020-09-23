resource "aws_kms_key" "dynamodb_key" {
  description             = "${var.username}-${var.environment}-dynamodb-key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_key" "lambda_key" {
  description             = "${var.username}-${var.environment}-lambda-key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}