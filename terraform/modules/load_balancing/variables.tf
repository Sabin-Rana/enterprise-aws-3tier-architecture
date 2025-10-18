# ==============================================================================
# LOAD BALANCING MODULE - INPUT VARIABLES
# ==============================================================================

# This file defines all input variables required by the load balancing module
# These variables configure Application Load Balancers and target groups

# ------------------------------------------------------------------------------
# PROJECT & TAGGING VARIABLES
# ------------------------------------------------------------------------------

# Project identifier used for resource naming and tagging
variable "project_name" {
  description = "Name of the project for resource naming and tagging"
  type        = string
}

# Common tags applied to all resources for organization and cost tracking
variable "common_tags" {
  description = "Common tags to be applied to all resources in the module"
  type        = map(string)
  default     = {}
}

# ------------------------------------------------------------------------------
# LOAD BALANCER CONFIGURATION VARIABLES
# ------------------------------------------------------------------------------

# Determines if the ALB is internal (private) or external (public)
variable "internal" {
  description = "Whether the ALB is internal (true) for private subnets or external (false) for public subnets"
  type        = bool
  default     = true
}

# Security group that controls traffic to and from the load balancer
variable "alb_security_group_id" {
  description = "Security group ID for the ALB - controls inbound/outbound traffic rules"
  type        = string
}

# Subnets where the load balancer will be deployed - determines availability zones
variable "subnet_ids" {
  description = "List of subnet IDs for the ALB - ensures multi-AZ deployment for high availability"
  type        = list(string)
}

# Prevents accidental deletion of the load balancer in production
variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB - prevents accidental deletion in production"
  type        = bool
  default     = false
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