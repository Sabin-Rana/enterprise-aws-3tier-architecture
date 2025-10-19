#!/bin/bash
# ==============================================================================
# POST-DEPLOYMENT VERIFICATION - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This script verifies successful infrastructure deployment
# Checks resource health and provides cost control reminders
# Use after every terraform apply to ensure deployment success
# ==============================================================================

echo "POST-DEPLOYMENT VERIFICATION"
echo "============================"

echo "1. Checking deployed resources..."
./quick-cost-check.sh

echo ""
echo "2. Checking resource health..."
echo "EC2 Instances:"
aws ec2 describe-instances --query 'Reservations[].Instances[?State.Name==`running`].{Instance:InstanceId, State:State.Name}' --output table 2>/dev/null

echo ""
echo "RDS Databases:"
aws rds describe-db-instances --query 'DBInstances[?DBInstanceStatus==`available`].{DB:DBInstanceIdentifier, Status:DBInstanceStatus}' --output table 2>/dev/null

echo ""
echo "3. Cost warning reminder:"
echo "  Remember to destroy resources within 20 minutes"
echo " Current time: $(date)"
echo " Run './safety-destroy.sh' before $(date -d '+20 minutes')"