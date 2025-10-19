# ==============================================================================
# SECURITY MODULE VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines input variables for the security module configuration
# Variables control security group rules and network access policies
# ==============================================================================

# VPC Configuration
variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

# Project Configuration
variable "project_name" {
  description = "Project name for security group naming and tagging"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all security group resources"
  type        = map(string)
  default     = {}
}

# Application Configuration
variable "app_port" {
  description = "Port number for application traffic between tiers"
  type        = number
  default     = 4000
}

# Security Configuration
variable "allowed_ssh_ips" {
  description = "List of IP addresses allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}