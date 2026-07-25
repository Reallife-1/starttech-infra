output "frontend_bucket_name" {
  description = "S3 frontend bucket name"
  value       = module.storage.frontend_bucket_id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.cdn.distribution_id
}

output "cloudfront_distribution_domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.cdn.distribution_domain_name
}

output "ecr_repository_url" {
  description = "Backend ECR repository URL"
  value       = module.storage.ecr_repository_url
}