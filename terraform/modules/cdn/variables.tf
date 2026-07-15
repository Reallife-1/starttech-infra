variable "s3_bucket_regional_domain_name" {
  description = "Regional domain name of the S3 frontend bucket"
  type        = string
}

variable "s3_bucket_id" {
  description = "ID of the S3 frontend bucket"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the backend ALB (placeholder until backend is deployed)"
  type        = string
  default     = "placeholder-alb.us-east-1.elb.amazonaws.com"
}

variable "environment" {
  description = "Environment name"
  type        = string
}