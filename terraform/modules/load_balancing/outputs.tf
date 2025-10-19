# ==============================================================================
# LOAD BALANCING MODULE OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines output values for the load balancing module
# Outputs provide load balancer and target group information for integration
# ==============================================================================

# Load Balancer Outputs
output "alb_arn" {
  description = "ARN of the application load balancer"
  value       = aws_lb.app_alb.arn
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value       = aws_lb.app_alb.dns_name
}

output "alb_zone_id" {
  description = "Route53 zone ID of the application load balancer"
  value       = aws_lb.app_alb.zone_id
}

# Target Group Outputs
output "target_group_arn" {
  description = "ARN of the application target group"
  value       = aws_lb_target_group.app_tg.arn
}

output "target_group_name" {
  description = "Name of the application target group"
  value       = aws_lb_target_group.app_tg.name
}