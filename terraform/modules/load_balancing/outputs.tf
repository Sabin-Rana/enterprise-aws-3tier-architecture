# ==============================================================================
# LOAD BALANCING MODULE - OUTPUT VARIABLES
# ==============================================================================

# This file defines output values that other modules can reference
# Outputs expose important load balancer identifiers and endpoints

# ------------------------------------------------------------------------------
# LOAD BALANCER OUTPUTS
# ------------------------------------------------------------------------------

# Load Balancer ARN - unique identifier for IAM policies and integrations
output "alb_arn" {
  description = "ARN of the Application Load Balancer - used for IAM policies and integrations"
  value       = aws_lb.app_alb.arn
}

# Load Balancer DNS Name - endpoint for accessing the application
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer - endpoint for application access"
  value       = aws_lb.app_alb.dns_name
}

# Load Balancer Zone ID - used for Route53 alias records
output "alb_zone_id" {
  description = "Route53 zone ID of the Application Load Balancer - used for DNS alias records"
  value       = aws_lb.app_alb.zone_id
}

# ------------------------------------------------------------------------------
# TARGET GROUP OUTPUTS
# ------------------------------------------------------------------------------

# Target Group ARN - used by Auto Scaling Group to register instances
output "target_group_arn" {
  description = "ARN of the target group - used by Auto Scaling Group to register EC2 instances"
  value       = aws_lb_target_group.app_tg.arn
}

# Target Group Name - useful for monitoring and debugging
output "target_group_name" {
  description = "Name of the target group - useful for monitoring and AWS Console identification"
  value       = aws_lb_target_group.app_tg.name
}