


# To keep naming scheme consistent, define them there
locals {
  prefix = "${var.project}-${var.username}-${var.environment}"

  bucket_name = "${local.prefix}-static-content"
}

# Zip up all Lambdas so that they can be deployed
data "archive_file" "lambdas" {
  type        = "zip"
  source_dir  = "${path.module}/files/lambda"
  output_path = "${path.module}/files/lambda.zip"
}

# Create API Gateway SDK Config Javascript from template
#
# This was exported from a deployment of the current API
# and the URL was replaced with a variable
data "template_file" "apigw_js_config" {
  template = file("files/apigClient.js.tpl")
  vars = {
    invoke_url = aws_api_gateway_deployment.deployment.invoke_url
  }
}

# Create Javascript file from API Gateway SDK Config template
resource "aws_s3_bucket_object" "apigw_js" {
  key     = "js/apigClient.js"
  bucket  = "${local.prefix}-static-content"
  content = data.template_file.apigw_js_config.rendered
}
