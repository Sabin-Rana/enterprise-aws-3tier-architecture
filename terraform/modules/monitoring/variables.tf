# ==============================================================================
# MONITORING MODULE VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines input variables for the monitoring module configuration
# Variables control CloudWatch dashboards, alarms, and observability settings
# ==============================================================================

# Project Configuration
variable "project_name" {
  description = "Project name for monitoring resource naming and tagging"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all monitoring resources"
  type        = map(string)
  default     = {}
}

# AWS Region Configuration
variable "aws_region" {
  description = "AWS region for monitoring resources and metrics"
  type        = string
  default     = "us-east-1"
}

# VPC Configuration
variable "vpc_id" {
  description = "VPC ID for VPC flow logs monitoring"
  type        = string
}

# Auto Scaling Group Configuration
variable "web_asg_name" {
  description = "Web tier auto scaling group name for CPU monitoring"
  type        = string
}

variable "app_asg_name" {
  description = "Application tier auto scaling group name for CPU monitoring"
  type        = string
}

# Load Balancer Configuration
variable "external_alb_name" {
  description = "External load balancer name for health monitoring"
  type        = string
}

# Database Configuration
variable "db_instance_id" {
  description = "RDS database instance identifier for performance monitoring"
  type        = string
}

# Internal Load Balancer Configuration
variable "internal_alb_name" {
  description = "Internal load balancer name for health monitoring"
  type        = string
  default     = ""
}