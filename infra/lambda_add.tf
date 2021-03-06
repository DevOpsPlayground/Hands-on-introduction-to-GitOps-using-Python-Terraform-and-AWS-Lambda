
resource "aws_lambda_function" "lambda_add_function" {
  filename      = "files/lambda.zip"
  function_name = "${local.prefix}-todolist-add"
  role          = aws_iam_role.lambda_list_role.arn
  handler       = "add.lambda_handler"

  kms_key_arn = aws_kms_key.lambda_key.arn

  source_code_hash = data.archive_file.lambdas.output_base64sha256


  runtime = "python3.8"

  environment {
    variables = {
      DYNAMODB_DB_TABLE_NAME = aws_dynamodb_table.todolist_table.id
    }
  }
}

module "add_method" {
  source = "./modules/apigw-method"

  lambda_arn        = aws_lambda_function.lambda_add_function.arn
  api_id            = aws_api_gateway_rest_api.cors_api.id
  api_execution_arn = aws_api_gateway_rest_api.cors_api.execution_arn
  resource_id       = module.api_item.id
  method            = "POST"

}
