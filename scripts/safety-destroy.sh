#!/bin/bash
# ENTERPRISE 3-TIER SAFETY DESTROY
# Emergency cost containment for 3-tier architecture

echo "ENTERPRISE 3-TIER SAFETY DESTROY"
echo "================================"
echo "Project: enterprise-aws-3tier-architecture"
echo "Time: $(date)"
echo ""

echo " EMERGENCY DESTROY ACTIVATED "
echo "This will destroy ALL Terraform-managed resources"
echo ""

# Check current resources before destroy
echo "=== RESOURCES BEFORE DESTROY ==="
./quick-cost-check.sh

echo ""
echo "WARNING: This will permanently delete all infrastructure"
read -p "Type 'DESTROY' to confirm: " confirmation

if [ "$confirmation" != "DESTROY" ]; then
    echo "Destroy cancelled"
    exit 1
fi

echo ""
echo "Starting destruction sequence..."

# Primary: Terraform destroy in production environment
if [ -d "../terraform/environments/production" ]; then
    echo "1. Destroying production environment..."
    cd ../terraform/environments/production
    terraform destroy -auto-approve
    cd ../../..
fi

echo ""
echo "=== DESTRUCTION COMPLETE ==="
echo "Waiting 30 seconds for AWS to update..."
sleep 30

echo ""
echo "=== FINAL RESOURCE CHECK ==="
./quick-cost-check.sh

echo ""
echo " SAFETY DESTROY COMPLETE"
echo " All resources destroyed - Cost bleeding prevented"
echo ""
echo "Next: Run './cost-checker.sh' for detailed verification"
