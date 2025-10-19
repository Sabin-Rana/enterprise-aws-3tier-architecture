#!/bin/bash
# ==============================================================================
# PRE-DEPLOYMENT SAFETY CHECK - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This script performs safety checks before infrastructure deployment
# Verifies current resource state and requires manual deployment approval
# Use before every terraform apply to prevent cost overruns
# ==============================================================================

echo "PRE-DEPLOYMENT SAFETY CHECK"
echo "==========================="

# Check current AWS resource state
./quick-cost-check.sh

# Terraform plan verification
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

# Manual deployment approval
echo ""
echo "=== DEPLOYMENT APPROVAL ==="
read -p "Do you want to proceed with deployment? (yes/no): " approval

if [ "$approval" != "yes" ]; then
    echo "Deployment cancelled"
    exit 1
fi

echo "Deployment approved - Proceeding with caution"
echo "Remember: Run './post-deploy-check.sh' after deployment"