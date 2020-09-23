locals {
  table_name = "${local.prefix}-todolist-table"
}

resource "aws_dynamodb_table" "todolist_table" {
  name         = local.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "item_id"

  /* TODO: remove these to demo the security scanning */
  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.dynamodb_key.arn
  }

  attribute {
    name = "item_id"
    type = "N"
  }


  tags = {
    Name        = local.table_name
    Environment = var.environment
    Creator     = var.username
  }
}
