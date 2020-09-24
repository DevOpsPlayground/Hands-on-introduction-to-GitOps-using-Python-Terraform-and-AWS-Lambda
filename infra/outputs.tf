output "s3_bucket" {
  value = "${local.prefix}-static-content"
}

output "domain_content" {
  value = aws_s3_bucket.website.bucket_domain_name
}
