# ==============================================================================
# PRODUCTION VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines production-specific variables and configurations
# These values are optimized for production environment deployment
# ==============================================================================

# Project and Environment Configuration
variable "project_name" {
  description = "Name of the project for resource naming and tagging"
  type        = string
  default     = "enterprise-aws-3tier"
}

variable "environment" {
  description = "Deployment environment identifier"
  type        = string
  default     = "production"
}

variable "owner" {
  description = "Resource owner for cost tracking and management"
  type        = string
  default     = "Sabin Rana"
}

# AWS Region Configuration
variable "aws_region" {
  description = "AWS region for production deployment"
  type        = string
  default     = "us-east-1"
}

# Network Configuration
variable "vpc_cidr" {
  description = "CIDR block for production VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for production public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for production application subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for production database subnets"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "app_port" {
  description = "Application port for production backend service"
  type        = number
  default     = 4000
}

# Database Configuration
variable "db_instance_class" {
  description = "RDS instance class for production database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Database username for production environment"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password for production environment"
  type        = string
  sensitive   = true
  default     = "TempPassword123!"
}

variable "db_name" {
  description = "Database name for production application"
  type        = string
  default     = "appdb"
}

# Compute Configuration
variable "ami_id" {
  description = "AMI ID for production EC2 instances"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "app_instance_type" {
  description = "EC2 instance type for production application tier"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name for production instances"
  type        = string
  default     = ""
}

# Auto Scaling Configuration
variable "app_min_size" {
  description = "Minimum instance count for production auto scaling group"
  type        = number
  default     = 2
}

variable "app_max_size" {
  description = "Maximum instance count for production auto scaling group"
  type        = number
  default     = 4
}

variable "app_desired_capacity" {
  description = "Desired instance count for production auto scaling group"
  type        = number
  default     = 2
}