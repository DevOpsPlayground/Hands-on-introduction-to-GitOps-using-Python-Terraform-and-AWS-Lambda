output "s3_bucket" {
  value = module.static_site.s3_bucket
}

output "domain_content" {
  value = module.static_site.cf_domain_name
}

output "domain_api" {
  value = local.domain_api
}
