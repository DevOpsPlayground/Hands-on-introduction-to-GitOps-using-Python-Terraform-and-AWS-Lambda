module "static_site" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.34.1"
  # insert the 1 required variable here

  name = "${local.prefix}-static"

}
