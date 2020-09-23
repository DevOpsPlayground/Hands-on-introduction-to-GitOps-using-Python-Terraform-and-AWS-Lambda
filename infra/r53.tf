data "aws_route53_zone" "parent_zone" {
  name         = local.domain
  private_zone = false
}
