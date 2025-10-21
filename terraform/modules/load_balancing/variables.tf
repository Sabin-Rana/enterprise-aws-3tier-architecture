# ==============================================================================
# LOAD BALANCING MODULE VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines input variables for the load balancing module configuration
# Variables control load balancer type, target groups, and listener configuration
# ==============================================================================

# Load Balancer Configuration
variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal or internet-facing"
  type        = bool
  default     = true
}

variable "alb_security_group_id" {
  description = "Security group ID for load balancer network access"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for load balancer deployment"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for load balancer"
  type        = bool
  default     = false
}

# Target Group Configuration
variable "app_port" {
  description = "Port number for target group application traffic"
  type        = number
  default     = 4000
}

variable "app_protocol" {
  description = "Protocol for target group application traffic"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "VPC ID for target group deployment"
  type        = string
}

variable "health_check_path" {
  description = "Health check path for target group instances"
  type        = string
  default     = "/health"
}

# Listener Configuration
variable "listener_port" {
  description = "Port number for load balancer listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocol for load balancer listener"
  type        = string
  default     = "HTTP"
}

# Tagging Configuration
variable "tags" {
  description = "Tags applied to all load balancing resources"
  type        = map(string)
  default     = {}
}