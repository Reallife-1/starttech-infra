output "distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.starttech-cdn.id
}

output "distribution_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.starttech-cdn.domain_name
}