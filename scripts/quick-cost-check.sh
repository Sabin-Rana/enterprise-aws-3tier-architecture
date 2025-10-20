#!/bin/bash

# ==============================================================================
# QUICK COST CHECK - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# Quick safety check for costly AWS resources
# Run before/after every Terraform session to prevent billing surprises
# ==============================================================================

set -e  # Exit on any error

echo "QUICK COST CHECK - Checking for costly AWS resources..."
echo "=========================================================="

# Check for running EC2 instances (using text processing instead of jq)
ec2_count=$(aws ec2 describe-instances --query "Reservations[].Instances[?State.Name=='running'].InstanceId" --output text | wc -w)
echo "EC2 Instances running: $ec2_count"

# Check for RDS instances
rds_count=$(aws rds describe-db-instances --query "DBInstances[?DBInstanceStatus=='available'].DBInstanceIdentifier" --output text | wc -w)
echo "RDS Databases running: $rds_count"

# Check for NAT Gateways
nat_count=$(aws ec2 describe-nat-gateways --filter "Name=state,Values=available" --query "NatGateways[].NatGatewayId" --output text | wc -w)
echo "NAT Gateways running: $nat_count"

# Check for Load Balancers
alb_count=$(aws elbv2 describe-load-balancers --query "LoadBalancers[].LoadBalancerName" --output text | wc -w)
echo "ALB Load Balancers: $alb_count"

# Summary
total_resources=$((ec2_count + rds_count + nat_count + alb_count))

echo "=========================================================="
if [ $total_resources -eq 0 ]; then
    echo "STATUS: ALL CLEAN - No costly resources running"
    echo "You're safe to proceed with deployment"
else
    echo "WARNING: $total_resources costly resources detected!"
    echo "Run ./cost-checker.sh for detailed listing"
    echo "Consider running ./safety-destroy.sh if unexpected"
fi
echo "=========================================================="
