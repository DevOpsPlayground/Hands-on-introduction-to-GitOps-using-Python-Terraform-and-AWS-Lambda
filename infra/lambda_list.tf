resource "aws_lambda_function" "lambda_list_function" {
  filename      = "files/lambda.zip"
  function_name = "${local.prefix}-todolist-list"
  role          = aws_iam_role.lambda_list_role.arn
  handler       = "list.lambda_handler"

  kms_key_arn = aws_kms_key.lambda_key.arn

  source_code_hash = data.archive_file.lambdas.output_base64sha256

  runtime = "python3.8"

  environment {
    variables = {
      DYNAMODB_DB_TABLE_NAME = aws_dynamodb_table.todolist_table.id
    }
  }
}

module "list_method" {
  source = "./modules/apigw-method"

  lambda_arn        = aws_lambda_function.lambda_list_function.arn
  api_id            = aws_api_gateway_rest_api.cors_api.id
  api_execution_arn = aws_api_gateway_rest_api.cors_api.execution_arn
  resource_id       = aws_api_gateway_rest_api.cors_api.root_resource_id
  method            = "GET"

}

