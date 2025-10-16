#!/bin/bash
# Pre-Deployment Safety Check
# Run before ANY terraform apply

echo "PRE-DEPLOYMENT SAFETY CHECK"
echo "==========================="

# Check current resource count
./quick-cost-check.sh

# Check Terraform plan
echo ""
echo "=== TERRAFORM PLAN CHECK ==="
if [ -d "../terraform/environments/production" ]; then
    cd ../terraform/environments/production
    echo "Running terraform plan..."
    terraform plan
    cd ../../..
else
    echo "Production environment not found"
fi

echo ""
echo "=== DEPLOYMENT APPROVAL ==="
read -p "Do you want to proceed with deployment? (yes/no): " approval

if [ "$approval" != "yes" ]; then
    echo "Deployment cancelled"
    exit 1
fi

echo "Deployment approved - Proceeding with caution"
echo "Remember: Run './post-deploy-check.sh' after deployment"
