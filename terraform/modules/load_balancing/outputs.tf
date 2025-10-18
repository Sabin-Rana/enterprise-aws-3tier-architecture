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
# TARGET GROUP CONFIGURATION VARIABLES
# ------------------------------------------------------------------------------

# Application port that the target group listens on
variable "app_port" {
  description = "Port that the application listens on - target group routes traffic to this port"
  type        = number
  default     = 4000
}

# Application protocol (HTTP or HTTPS) for the target group
variable "app_protocol" {
  description = "Protocol for the target group - HTTP for internal, HTTPS for external with SSL"
  type        = string
  default     = "HTTP"
}

# VPC ID where the target group resources are located
variable "vpc_id" {
  description = "VPC ID where the target group resources are located - required for target group creation"
  type        = string
}

# Health check path used to determine instance health
variable "health_check_path" {
  description = "Health check path for target group - endpoint used to determine instance health"
  type        = string
  default     = "/health"
}