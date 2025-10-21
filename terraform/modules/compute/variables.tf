# ==============================================================================
# COMPUTE MODULE VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines input variables for the compute module configuration
# Variables control EC2 instances, auto scaling, and application deployment
# ==============================================================================

# Project Configuration
variable "project_name" {
  description = "Project name for compute resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment for compute resource naming and tagging"
  type        = string
}

variable "tier" {
  description = "Tier name (web, app) for resource identification"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all compute resources"
  type        = map(string)
  default     = {}
}

# EC2 Instance Configuration
variable "ami_id" {
  description = "AMI ID for EC2 instances (Amazon Linux 2)"
  type        = string
  default     = "ami-0023921b4fcd5382b"
}

variable "instance_type" {
  description = "EC2 instance type for application tier"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name for instance access"
  type        = string
  default     = ""
}

# Security Configuration
variable "app_security_group_id" {
  description = "Security group ID for application instances"
  type        = string
}

variable "user_data" {
  description = "User data script for instance initialization"
  type        = string
  default     = ""
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name for SSM access"
  type        = string
  default     = "AmazonSSMManagedInstanceCore"
}

# Auto Scaling Configuration
variable "min_size" {
  description = "Minimum number of instances in auto scaling group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances in auto scaling group"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Desired number of instances in auto scaling group"
  type        = number
  default     = 2
}

# Network Configuration
variable "private_subnet_ids" {
  description = "List of private subnet IDs for instance deployment"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs for load balancer integration"
  type        = list(string)
  default     = []
}