#!/bin/bash
# ==============================================================================
# ENTERPRISE AWS 3-TIER - EMERGENCY RESOURCE DESTRUCTION
# ==============================================================================
# NUCLEAR OPTION: Destroys ALL resources across ALL regions
# Use ONLY when comprehensive cost check finds resources
# WARNING: This will PERMANENTLY DELETE all AWS resources
# ==============================================================================

echo "EMERGENCY RESOURCE DESTRUCTION - ALL REGIONS"
echo "============================================="
echo "WARNING: This will PERMANENTLY DELETE all AWS resources"
echo "Project: enterprise-aws-3tier-architecture"
echo "Date: $(date)"
echo ""

# Safety confirmation
read -p "Type 'NUKE_ALL' to confirm destruction of ALL resources: " confirmation

if [ "$confirmation" != "NUKE_ALL" ]; then
    echo "CANCELLED: No resources destroyed."
    exit 1
fi

echo ""
echo "CONFIRMED: Beginning emergency destruction..."
echo ""

# Define ALL AWS regions
REGIONS=("us-east-1" "us-east-2" "us-west-1" "us-west-2" "eu-west-1" "eu-central-1")

for region in "${REGIONS[@]}"; do
    echo "=== DESTROYING REGION: $region ==="
    
    # Terminate ALL EC2 instances
    echo "Terminating EC2 instances..."
    instances=$(aws ec2 describe-instances --region $region --query 'Reservations[].Instances[].InstanceId' --output text 2>/dev/null)
    if [ ! -z "$instances" ]; then
        aws ec2 terminate-instances --region $region --instance-ids $instances
        echo "Terminated instances: $instances"
    else
        echo "No EC2 instances found"
    fi
    
    # Delete ALL NAT Gateways
    echo "Deleting NAT Gateways..."
    nat_gateways=$(aws ec2 describe-nat-gateways --region $region --filter "Name=state,Values=available,pending" --query 'NatGateways[].NatGatewayId' --output text 2>/dev/null)
    if [ ! -z "$nat_gateways" ]; then
        for nat_gateway in $nat_gateways; do
            aws ec2 delete-nat-gateway --region $region --nat-gateway-id $nat_gateway
            echo "Deleted NAT Gateway: $nat_gateway"
        done
    else
        echo "No NAT Gateways found"
    fi
    
    # Release ALL Elastic IPs
    echo "Releasing Elastic IPs..."
    addresses=$(aws ec2 describe-addresses --region $region --query 'Addresses[].AllocationId' --output text 2>/dev/null)
    if [ ! -z "$addresses" ]; then
        for address in $addresses; do
            aws ec2 release-address --region $region --allocation-id $address
            echo "Released Elastic IP: $address"
        done
    else
        echo "No Elastic IPs found"
    fi
    
    # Delete ALL Load Balancers
    echo "Deleting Load Balancers..."
    load_balancers=$(aws elbv2 describe-load-balancers --region $region --query 'LoadBalancers[].LoadBalancerArn' --output text 2>/dev/null)
    if [ ! -z "$load_balancers" ]; then
        for lb in $load_balancers; do
            aws elbv2 delete-load-balancer --region $region --load-balancer-arn $lb
            echo "Deleted Load Balancer: $lb"
        done
    else
        echo "No Load Balancers found"
    fi
    
    # Delete ALL RDS instances
    echo "Deleting RDS instances..."
    rds_instances=$(aws rds describe-db-instances --region $region --query 'DBInstances[].DBInstanceIdentifier' --output text 2>/dev/null)
    if [ ! -z "$rds_instances" ]; then
        for rds in $rds_instances; do
            aws rds delete-db-instance --region $region --db-instance-identifier $rds --skip-final-snapshot --delete-automated-backups
            echo "Deleted RDS instance: $rds"
        done
    else
        echo "No RDS instances found"
    fi
    
    echo "---"
done

echo ""
echo "DESTRUCTION COMPLETE"
echo "===================="
echo "All resources across all regions have been scheduled for deletion."
echo "Some resources may take a few minutes to fully terminate."
echo ""
echo "Run './scripts/comprehensive-cost-check.sh' in 5 minutes to verify cleanup."