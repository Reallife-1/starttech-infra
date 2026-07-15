variable "redis_cluster_id" {
  description = "ElastiCache Redis cluster identifier"
  type        = string
  default     = "starttech-redis"
}

variable "node_type" {
  description = "ElastiCache node instance type"
  type        = string
  default     = "cache.t3.micro"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the cache subnet group"
  type        = list(string)
}

variable "eks_node_security_group_id" {
  description = "Security group ID of EKS worker nodes, for restricting Redis access"
  type        = string
}