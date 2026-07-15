output "frontend_bucket_id" {
  description = "ID of the S3 frontend bucket"
  value       = aws_s3_bucket.frontend.id
}

output "frontend_bucket_arn" {
  description = "ARN of the S3 frontend bucket"
  value       = aws_s3_bucket.frontend.arn
}

output "frontend_bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket, needed for CloudFront origin"
  value       = aws_s3_bucket.frontend.bucket_regional_domain_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.backend.repository_url
}