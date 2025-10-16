#!/bin/bash
# ENTERPRISE AWS 3-TIER - COST CHECKER

echo "ENTERPRISE 3-TIER COST CHECKER"
echo "==============================="
echo "Project: enterprise-aws-3tier-architecture"
echo "Date: $(date)"
echo ""

# Function to check resources
check_resource() {
    local service=$1
    local command=$2
    local query=$3
    local description=$4

    echo "Checking: $description"
    result=$(eval "aws $command --query '$query' --output table 2>/dev/null")
    
    if [ -z "$result" ] || [ "$result" = "None" ]; then
        echo "   No resources found"
    else
        echo "   Resources found (may incur costs):"
        echo "$result"
    fi
    echo ""
}

# HIGH COST SERVICES
echo "=== HIGH COST SERVICES ==="
check_resource "EC2" "ec2 describe-instances" 'Reservations[].Instances[?State.Name==`running`].{Instance:InstanceId, Type:InstanceType, State:State.Name}' "Running EC2 Instances"
check_resource "RDS" "rds describe-db-instances" 'DBInstances[?DBInstanceStatus==`available`].{DB:DBInstanceIdentifier, Engine:Engine, Class:DBInstanceClass, Status:DBInstanceStatus}' "Running RDS Databases"
check_resource "ALB" "elbv2 describe-load-balancers" 'LoadBalancers[].{LB:LoadBalancerName, Type:Type, State:State.Code}' "Load Balancers"
check_resource "NAT" "ec2 describe-nat-gateways" 'NatGateways[?State==`available`].{NatGatewayId:NatGatewayId, State:State}' "NAT Gateways"

# COST SUMMARY
echo "=== COST SUMMARY ==="
ec2_count=$(aws ec2 describe-instances --query 'Reservations[].Instances[?State.Name==`running`].InstanceId' --output text 2>/dev/null | wc -w)
rds_count=$(aws rds describe-db-instances --query 'length(DBInstances[?DBInstanceStatus==`available`])' --output text 2>/dev/null)
alb_count=$(aws elbv2 describe-load-balancers --query 'length(LoadBalancers)' --output text 2>/dev/null)
nat_count=$(aws ec2 describe-nat-gateways --query 'length(NatGateways[?State==`available`])' --output text 2>/dev/null)

total_costly_resources=$((ec2_count + rds_count + alb_count + nat_count))

echo "Running EC2 Instances: $ec2_count"
echo "RDS Databases: $rds_count"
echo "Load Balancers: $alb_count"
echo "NAT Gateways: $nat_count"
echo ""

if [ $total_costly_resources -eq 0 ]; then
    echo " COST STATUS: ALL CLEAN - No costly resources running"
else
    echo " COST STATUS: WARNING - $total_costly_resources costly resources found"
    echo "ACTION REQUIRED: Run './scripts/safety-destroy.sh' to prevent cost overruns"
fi

echo ""
echo "=== BUDGET STATUS ==="
echo "Project Budget: $2.00 TOTAL"
echo "Phase 3 Budget: $0.01 (20 minutes RDS)"
echo "Remaining: $1.00-1.50"
echo ""
echo "Run this after every Terraform session!"
