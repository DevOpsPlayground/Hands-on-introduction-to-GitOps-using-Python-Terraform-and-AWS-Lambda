data "archive_file" "lambdas" {
  type        = "zip"
  source_dir  = "${path.module}/files/lambda"
  output_path = "${path.module}/files/lambda.zip"
}

locals {
  prefix         = "${var.project}-${var.username}-${var.environment}"
  domain         = "gitops.devopsplayground.org"
  domain_env     = "${local.domain}"
  domain_content = "content-${var.environment}-${var.username}.${local.domain_env}"
  domain_api     = "api-${var.environment}-${var.username}.${local.domain_env}"
}

data "template_file" "apigw_js_config" {
  template = "${file("files/apigClient.js.tpl")}"
  vars = {
    invoke_url = aws_api_gateway_deployment.deployment.invoke_url
  }
}

resource "aws_s3_bucket_object" "apigw_js" {
  key     = "js/apigClient.js"
  bucket  = module.static_site.s3_bucket
  content = data.template_file.apigw_js_config.rendered
}
