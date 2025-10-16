
#!/bin/bash
# Quick Cost Safety Check - Run after every Terraform session

echo "QUICK 3-TIER COST CHECK"
echo "======================="

# Check each critical service
ec2_count=$(aws ec2 describe-instances --query 'Reservations[].Instances[?State.Name==`running`].InstanceId' --output text 2>/dev/null | wc -w)
rds_count=$(aws rds describe-db-instances --query 'DBInstances[?DBInstanceStatus==`available`].DBInstanceIdentifier' --output text 2>/dev/null | wc -w)
alb_count=$(aws elbv2 describe-load-balancers --query 'length(LoadBalancers)' --output text 2>/dev/null)
nat_count=$(aws ec2 describe-nat-gateways --query 'length(NatGateways[?State==`available`])' --output text 2>/dev/null)

echo "Critical Resources Found:"
echo "EC2 Instances: $ec2_count"
echo "RDS Databases: $rds_count"
echo "Load Balancers: $alb_count"
echo "NAT Gateways: $nat_count"

total=$((ec2_count + rds_count + alb_count + nat_count))

if [ $total -eq 0 ]; then
    echo "STATUS: ALL CLEAN - No costly resources running"
    echo "Safe to proceed with deployments"
else
    echo "STATUS: WARNING - $total costly resources found"
    echo "ACTION: Run './scripts/safety-destroy.sh' immediately"
    echo "DO NOT PROCEED until resources are destroyed"
fi
