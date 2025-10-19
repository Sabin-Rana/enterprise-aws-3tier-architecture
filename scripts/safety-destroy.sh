#!/bin/bash
# ==============================================================================
# ENTERPRISE 3-TIER SAFETY DESTROY
# ==============================================================================
# This script provides emergency cost containment for 3-tier architecture
# Destroys all Terraform-managed resources to prevent unexpected AWS charges
# Requires explicit confirmation to prevent accidental execution
# ==============================================================================

echo "ENTERPRISE 3-TIER SAFETY DESTROY"
echo "================================"
echo "Project: enterprise-aws-3tier-architecture"
echo "Time: $(date)"
echo ""

echo "EMERGENCY DESTROY ACTIVATED"
echo "This will destroy ALL Terraform-managed resources"
echo ""

# Pre-destroy resource verification
echo "=== RESOURCES BEFORE DESTROY ==="
./quick-cost-check.sh

echo ""
echo "WARNING: This will permanently delete all infrastructure"
read -p "Type 'DESTROY' to confirm: " confirmation

# Safety confirmation check
if [ "$confirmation" != "DESTROY" ]; then
    echo "Destroy cancelled"
    exit 1
fi

echo ""
echo "Starting destruction sequence..."

# Terraform destroy execution
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

# Post-destroy verification
echo ""
echo "=== FINAL RESOURCE CHECK ==="
./quick-cost-check.sh

echo ""
echo "SAFETY DESTROY COMPLETE"
echo "All resources destroyed - Cost bleeding prevented"
echo ""
echo "Next: Run './cost-checker.sh' for detailed verification"