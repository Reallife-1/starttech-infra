resource "aws_elasticache_subnet_group" "starttech-redis-subnet-group" {
  name       = "starttech-redis-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "redis_sg" {
  name        = "starttech-redis-sg"
  description = "Allow Redis access from EKS worker nodes only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Redis from EKS nodes"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [var.eks_node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "starttech-redis-sg"
  }
}

resource "aws_elasticache_cluster" "starttech-redis" {
  cluster_id           = var.redis_cluster_id
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.starttech-redis-subnet-group.name
  security_group_ids   = [aws_security_group.redis_sg.id]

  tags = {
    Name = "starttech-redis"
  }
}