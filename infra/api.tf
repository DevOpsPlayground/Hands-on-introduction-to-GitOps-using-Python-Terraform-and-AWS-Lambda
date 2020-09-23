
resource "aws_api_gateway_deployment" "deployment" {

  rest_api_id = aws_api_gateway_rest_api.cors_api.id
  stage_name  = var.environment

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_api_gateway_rest_api" "cors_api" {
  name        = "${local.prefix}-api"
  description = "API for the DPG Todo List ${var.environment} environment"
}

resource "aws_api_gateway_deployment" "deployment_2" {
  rest_api_id = aws_api_gateway_rest_api.cors_api.id
  stage_name  = "test"
  # depends_on  = ["aws_api_gateway_integration.integration_add", "aws_api_gateway_integration.integration_list"]
}


/*
- /
   * GET
- /item
   * POST
- /item/{item_id}
   * DELETE
- /item/{item_id}/start
   * GET
- /item/{item_id}/stop
   * GET
- /item/{item_id}/done
   * GET
*/


module "api_item" {
  source = "./modules/apigw-resource"

  root_resource     = aws_api_gateway_rest_api.cors_api.root_resource_id
  api_id            = aws_api_gateway_rest_api.cors_api.id
  api_execution_arn = aws_api_gateway_rest_api.cors_api.execution_arn

  name = "item"
}

module "api_item_id" {
  source = "./modules/apigw-resource"

  root_resource     = module.api_item.id
  api_id            = aws_api_gateway_rest_api.cors_api.id
  api_execution_arn = aws_api_gateway_rest_api.cors_api.execution_arn

  name = "{item_id}"
}

module "api_item_start" {
  source = "./modules/apigw-resource"

  root_resource     = module.api_item_id.id
  api_id            = aws_api_gateway_rest_api.cors_api.id
  api_execution_arn = aws_api_gateway_rest_api.cors_api.execution_arn

  name = "start"
}

module "api_item_done" {
  source = "./modules/apigw-resource"

  root_resource     = module.api_item_id.id
  api_id            = aws_api_gateway_rest_api.cors_api.id
  api_execution_arn = aws_api_gateway_rest_api.cors_api.execution_arn

  name = "done"
}

