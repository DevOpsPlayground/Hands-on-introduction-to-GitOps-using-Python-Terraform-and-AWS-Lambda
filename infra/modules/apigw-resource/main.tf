
resource "aws_api_gateway_resource" "gateway_resource" {
  path_part   = var.name
  parent_id   = var.root_resource
  rest_api_id = var.api_id
}
resource "aws_api_gateway_method" "options_method_item" {
  rest_api_id   = var.api_id
  resource_id   = aws_api_gateway_resource.gateway_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200_item" {
  rest_api_id = var.api_id
  resource_id = aws_api_gateway_resource.gateway_resource.id
  http_method = aws_api_gateway_method.options_method_item.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = ["aws_api_gateway_method.options_method_item"]
}
resource "aws_api_gateway_integration" "options_integration_item" {
  rest_api_id = var.api_id
  resource_id = aws_api_gateway_resource.gateway_resource.id
  http_method = aws_api_gateway_method.options_method_item.http_method

  request_templates = {
    "application/json" = jsonencode(
      {
        statusCode = 200
      }
    )
  }


  type       = "MOCK"
  depends_on = ["aws_api_gateway_method.options_method_item"]
}
resource "aws_api_gateway_integration_response" "options_integration_item_response" {
  rest_api_id = var.api_id
  resource_id = aws_api_gateway_resource.gateway_resource.id
  http_method = aws_api_gateway_method.options_method_item.http_method
  status_code = aws_api_gateway_method_response.options_200_item.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = ["aws_api_gateway_method_response.options_200_item"]
}


