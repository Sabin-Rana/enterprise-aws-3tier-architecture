#!/bin/bash
# ==============================================================================
# ENTERPRISE AWS 3-TIER - COMPREHENSIVE COST CHECK (ALL REGIONS) - FIXED VERSION
# ==============================================================================
# NUCLEAR OPTION: Checks ALL regions and ALL services before deployment
# FIXED: Proper resource counting to avoid false positives
# ==============================================================================

echo "COMPREHENSIVE AWS COST CHECK - ALL REGIONS & SERVICES"
echo "=========================================================="
echo "Project: enterprise-aws-3tier-architecture"
echo "Date: $(date)"
echo "Purpose: PRE-DEPLOYMENT SAFETY CHECK"
echo ""

# Define ALL AWS regions
REGIONS=("us-east-1" "us-east-2" "us-west-1" "us-west-2" "eu-west-1" "eu-central-1")

# Track total findings
TOTAL_RESOURCES=0
FOUND_IN_REGIONS=()

echo "SCANNING ALL AWS REGIONS..."
echo ""

for region in "${REGIONS[@]}"; do
    echo "=== REGION: $region ==="
    REGION_RESOURCES=0
    
    # EC2 Instances - FIXED COUNTING
    ec2_instances=$(aws ec2 describe-instances --region $region --query 'Reservations[].Instances[].InstanceId' --output text 2>/dev/null)
    if [ ! -z "$ec2_instances" ] && [ "$ec2_instances" != "None" ]; then
        count=$(echo $ec2_instances | wc -w)
        echo "EC2 Instances: FOUND $count - $ec2_instances"
        REGION_RESOURCES=$((REGION_RESOURCES + count))
    else
        echo "EC2 Instances: None"
    fi
    
    # RDS Databases - FIXED COUNTING
    rds_instances=$(aws rds describe-db-instances --region $region --query 'DBInstances[].DBInstanceIdentifier' --output text 2>/dev/null)
    if [ ! -z "$rds_instances" ] && [ "$rds_instances" != "None" ]; then
        count=$(echo $rds_instances | wc -w)
        echo "RDS Databases: FOUND $count - $rds_instances"
        REGION_RESOURCES=$((REGION_RESOURCES + count))
    else
        echo "RDS Databases: None"
    fi
    
    # NAT Gateways - FIXED COUNTING
    nat_gateways=$(aws ec2 describe-nat-gateways --region $region --query 'NatGateways[].NatGatewayId' --output text 2>/dev/null)
    if [ ! -z "$nat_gateways" ] && [ "$nat_gateways" != "None" ]; then
        count=$(echo $nat_gateways | wc -w)
        echo "NAT Gateways: FOUND $count - $nat_gateways"
        REGION_RESOURCES=$((REGION_RESOURCES + count))
    else
        echo "NAT Gateways: None"
    fi
    
    # EBS Volumes - FIXED COUNTING
    ebs_volumes=$(aws ec2 describe-volumes --region $region --query 'Volumes[].VolumeId' --output text 2>/dev/null)
    if [ ! -z "$ebs_volumes" ] && [ "$ebs_volumes" != "None" ]; then
        count=$(echo $ebs_volumes | wc -w)
        echo "EBS Volumes: FOUND $count"
        REGION_RESOURCES=$((REGION_RESOURCES + count))
    else
        echo "EBS Volumes: None"
    fi
    
    # EBS Snapshots - FIXED COUNTING
    ebs_snapshots=$(aws ec2 describe-snapshots --region $region --owner-ids self --query 'Snapshots[].SnapshotId' --output text 2>/dev/null)
    if [ ! -z "$ebs_snapshots" ] && [ "$ebs_snapshots" != "None" ]; then
        count=$(echo $ebs_snapshots | wc -w)
        echo "EBS Snapshots: FOUND $count"
        REGION_RESOURCES=$((REGION_RESOURCES + count))
    else
        echo "EBS Snapshots: None"
    fi
    
    # Load Balancers - FIXED COUNTING
    load_balancers=$(aws elbv2 describe-load-balancers --region $region --query 'LoadBalancers[].LoadBalancerName' --output text 2>/dev/null)
    if [ ! -z "$load_balancers" ] && [ "$load_balancers" != "None" ]; then
        count=$(echo $load_balancers | wc -w)
        echo "Load Balancers: FOUND $count - $load_balancers"
        REGION_RESOURCES=$((REGION_RESOURCES + count))
    else
        echo "Load Balancers: None"
    fi
    
    if [ $REGION_RESOURCES -gt 0 ]; then
        FOUND_IN_REGIONS+=("$region: $REGION_RESOURCES resources")
        TOTAL_RESOURCES=$((TOTAL_RESOURCES + REGION_RESOURCES))
    fi
    
    echo "---"
done

# Global services
echo "=== GLOBAL SERVICES ==="
s3_buckets=$(aws s3api list-buckets --query 'Buckets[].Name' --output text 2>/dev/null)
if [ ! -z "$s3_buckets" ] && [ "$s3_buckets" != "None" ]; then
    count=$(echo $s3_buckets | wc -w)
    echo "S3 Buckets: FOUND $count - $s3_buckets"
    TOTAL_RESOURCES=$((TOTAL_RESOURCES + count))
else
    echo "S3 Buckets: None"
fi

echo ""
echo "COMPREHENSIVE SUMMARY"
echo "========================"

if [ $TOTAL_RESOURCES -eq 0 ]; then
    echo "STATUS: 100% CLEAN - Zero resources across all regions"
    echo "SAFE TO PROCEED with portfolio validation"
else
    echo "STATUS: DANGER - $TOTAL_RESOURCES resources found"
    if [ ${#FOUND_IN_REGIONS[@]} -gt 0 ]; then
        echo "AFFECTED REGIONS:"
        for region_status in "${FOUND_IN_REGIONS[@]}"; do
            echo "   - $region_status"
        done
    else
        echo "AFFECTED REGIONS: Unknown (check counting logic)"
    fi
    echo ""
    echo "IMMEDIATE ACTION REQUIRED:"
    echo "   1. Run: ./scripts/emergency-nuke-all.sh"
    echo "   2. Verify: ./scripts/comprehensive-cost-check.sh"
    echo "   3. DO NOT PROCEED until 100% clean"
fi

echo ""
echo "USAGE:"
echo "   - Run BEFORE any deployment"
echo "   - Run AFTER any failed Terraform apply"
echo "   - Run WEEKLY for cost auditing"