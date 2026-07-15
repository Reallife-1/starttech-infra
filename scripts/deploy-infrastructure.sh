#!/bin/bash
set -euo pipefail

echo "Checking current public IP for security group rules..."
CURRENT_IP=$(curl -s https://checkip.amazonaws.com)
echo "Current IP: ${CURRENT_IP}"

cd "$(dirname "$0")/../terraform"

echo "Initializing Terraform..."
terraform init

echo "Formatting Terraform files..."
terraform fmt -recursive

echo "Validating Terraform configuration..."
terraform validate

echo "Planning infrastructure changes..."
terraform plan -out=tfplan

echo "Applying infrastructure changes..."
terraform apply tfplan

rm -f tfplan

echo "Infrastructure deployment complete."
echo "Fetching key outputs..."
terraform output