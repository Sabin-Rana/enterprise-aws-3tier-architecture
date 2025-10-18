# ==============================================================================
# COMPUTE MODULE - OUTPUT VARIABLES
# ==============================================================================

# This file defines output values that other modules can reference
# Outputs expose important resource identifiers and attributes

# ------------------------------------------------------------------------------
# LAUNCH TEMPLATE OUTPUTS
# ------------------------------------------------------------------------------

# Launch Template ID - used by Auto Scaling Groups and other resources
output "launch_template_id" {
  description = "ID of the launch template - used for referencing in Auto Scaling Groups"
  value       = aws_launch_template.app_launch_template.id
}

# Launch Template Name - useful for debugging and AWS Console identification
output "launch_template_name" {
  description = "Name of the launch template - useful for identification in AWS Console"
  value       = aws_launch_template.app_launch_template.name
}

# Launch Template Latest Version - ensures Auto Scaling uses current configuration
output "launch_template_latest_version" {
  description = "Latest version of the launch template - ensures Auto Scaling uses current configuration"
  value       = aws_launch_template.app_launch_template.latest_version
}

# ------------------------------------------------------------------------------
# AUTO SCALING GROUP OUTPUTS
# ------------------------------------------------------------------------------

# Auto Scaling Group Name - useful for monitoring and management
output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group - used for monitoring and management"
  value       = aws_autoscaling_group.app_asg.name
}

# Auto Scaling Group ARN - unique identifier for IAM policies and integrations
output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling Group - used for IAM policies and integrations"
  value       = aws_autoscaling_group.app_asg.arn
}