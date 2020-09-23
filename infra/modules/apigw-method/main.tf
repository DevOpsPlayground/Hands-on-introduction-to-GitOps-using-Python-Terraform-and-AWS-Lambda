
resource "aws_lambda_permission" "api" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${var.api_execution_arn}/*/*/*"
}


resource "aws_api_gateway_method" "method" {
  rest_api_id   = var.api_id
  resource_id   = var.resource_id
  http_method   = var.method
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "method_response_200" {
  rest_api_id = var.api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
  depends_on = [aws_api_gateway_method.method]
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = var.api_id
  resource_id             = var.resource_id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations"
  depends_on              = ["aws_api_gateway_method.method"]
}
