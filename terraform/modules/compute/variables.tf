# ==============================================================================
# COMPUTE MODULE - INPUT VARIABLES
# ==============================================================================

# This file defines all input variables required by the compute module
# These variables allow customization of EC2 instances and Auto Scaling behavior

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
# EC2 INSTANCE CONFIGURATION VARIABLES
# ------------------------------------------------------------------------------

# Amazon Machine Image ID - defines the operating system and pre-installed software
variable "ami_id" {
  description = "AMI ID for the EC2 instances - default is Amazon Linux 2 in us-east-1"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1
}

# EC2 instance type - determines CPU, memory, and network performance
variable "instance_type" {
  description = "EC2 instance type (t2.micro, t3.small, etc.) - default is t2.micro for free tier"
  type        = string
  default     = "t2.micro"
}

# SSH key pair name for EC2 instance access (optional - SSM preferred for security)
variable "key_name" {
  description = "SSH key pair name for EC2 instance access - leave empty to use SSM Session Manager"
  type        = string
  default     = ""
}

# ------------------------------------------------------------------------------
# SECURITY & ACCESS VARIABLES
# ------------------------------------------------------------------------------

# Security group ID that controls network access to application instances
variable "app_security_group_id" {
  description = "Security group ID for application instances - controls inbound/outbound traffic"
  type        = string
}

# User data script executed on instance launch for automated configuration
variable "user_data" {
  description = "User data script for instance initialization - executed on first boot"
  type        = string
  default     = ""
}

# IAM instance profile enabling EC2 instances to access AWS services securely
variable "iam_instance_profile_name" {
  description = "IAM instance profile name for SSM access - enables Session Manager without SSH"
  type        = string
}

# ------------------------------------------------------------------------------
# AUTO SCALING CONFIGURATION VARIABLES
# ------------------------------------------------------------------------------

# Minimum number of instances to maintain for high availability
variable "min_size" {
  description = "Minimum number of instances in Auto Scaling Group - ensures high availability"
  type        = number
  default     = 2
}

# Maximum number of instances to prevent over-scaling and cost overruns
variable "max_size" {
  description = "Maximum number of instances in Auto Scaling Group - prevents excessive scaling"
  type        = number
  default     = 4
}

# Desired number of instances for normal operation - between min and max
variable "desired_capacity" {
  description = "Desired number of instances in Auto Scaling Group - normal operating capacity"
  type        = number
  default     = 2
}

# ------------------------------------------------------------------------------
# NETWORKING VARIABLES
# ------------------------------------------------------------------------------

# List of private subnet IDs where application instances will be launched
variable "private_subnet_ids" {
  description = "List of private subnet IDs for Auto Scaling Group - ensures multi-AZ deployment"
  type        = list(string)
}

# Target group ARNs for load balancer integration - enables traffic distribution
variable "target_group_arns" {
  description = "List of target group ARNs for the Auto Scaling Group - connects to load balancer"
  type        = list(string)
  default     = []
}