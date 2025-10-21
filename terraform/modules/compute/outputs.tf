# ==============================================================================
# COMPUTE MODULE OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines output values for the compute module
# Outputs provide launch template and auto scaling group information
# ==============================================================================

# Launch Template Outputs
output "launch_template_id" {
  description = "ID of the application launch template"
  value       = aws_launch_template.main.id
}

output "launch_template_name" {
  description = "Name of the application launch template"
  value       = aws_launch_template.main.name
}

output "launch_template_latest_version" {
  description = "Latest version of the application launch template"
  value       = aws_launch_template.main.latest_version
}

# Auto Scaling Group Outputs
output "autoscaling_group_name" {
  description = "Name of the application auto scaling group"
  value       = aws_autoscaling_group.main.name
}

output "autoscaling_group_arn" {
  description = "ARN of the application auto scaling group"
  value       = aws_autoscaling_group.main.arn
}

output "autoscaling_group_id" {
  description = "ID of the application auto scaling group"
  value       = aws_autoscaling_group.main.id
}