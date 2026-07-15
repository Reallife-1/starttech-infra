variable "frontend_bucket_name" {
  description = "S3 bucket name for frontend static hosting"
  type        = string
  default     = "starttech-frontend-bucket"
}

variable "ecr_repository_name" {
  description = "ECR repository name for backend container images"
  type        = string
  default     = "starttech-backend-api"
}

variable "environment" {
  description = "Environment name"
  type        = string
}