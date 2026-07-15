terraform {
  required_version = ">= 1.5.0"

 required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "./modules/networking"

  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}

module "eks" {
  source = "./modules/eks"

  vpc_id              = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnet_ids
  public_subnet_ids   = module.networking.public_subnet_ids
}

module "storage" {
  source = "./modules/storage"

  environment = var.environment
}

module "database" {
  source = "./modules/database"

  vpc_id                     = module.networking.vpc_id
  private_subnet_ids         = module.networking.private_subnet_ids
  eks_node_security_group_id = module.eks.cluster_security_group_id
}

module "cdn" {
  source = "./modules/cdn"

  s3_bucket_regional_domain_name = module.storage.frontend_bucket_regional_domain_name
  s3_bucket_id                   = module.storage.frontend_bucket_id
  environment                    = var.environment
}