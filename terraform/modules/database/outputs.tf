output "redis_endpoint" {
  description = "Redis primary endpoint address"
  value       = aws_elasticache_cluster.starttech-redis.cache_nodes[0].address
}

output "redis_port" {
  description = "Redis port"
  value       = aws_elasticache_cluster.starttech-redis.port
}

output "redis_security_group_id" {
  description = "Security group ID attached to Redis"
  value       = aws_security_group.redis_sg.id
}