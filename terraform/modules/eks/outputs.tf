output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.starttech-cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint for the EKS control plane"
  value       = aws_eks_cluster.starttech-cluster.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data for cluster auth"
  value       = aws_eks_cluster.starttech-cluster.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = aws_eks_cluster.starttech-cluster.vpc_config[0].cluster_security_group_id
}

output "node_role_arn" {
  description = "ARN of the node group IAM role"
  value       = aws_iam_role.node_role.arn
}

output "node_security_group_id" {
  description = "Security group ID automatically created for the EKS node group"
  value       = aws_eks_cluster.starttech-cluster.vpc_config[0].cluster_security_group_id
}