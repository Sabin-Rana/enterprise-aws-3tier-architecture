# ==============================================================================
# TERRAFORM VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines all input variables for the infrastructure configuration
# Variables are organized by category: project, AWS, network, compute, database
# ==============================================================================

# Project and Environment Configuration
variable "project_name" {
  description = "Name of the project used for resource naming and tagging"
  type        = string
  default     = "enterprise-aws-3tier"
}

variable "environment" {
  description = "Deployment environment (development, staging, production)"
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
  description = "AWS region where all resources will be deployed"
  type        = string
  default     = "us-east-1"
}

# Network Configuration - VPC and Subnets
variable "vpc_cidr" {
  description = "CIDR block for the Virtual Private Cloud (VPC)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (web tier)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets (app tier)"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets (database tier)"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

# Compute Configuration - EC2 Instances
variable "web_instance_type" {
  description = "EC2 instance type for web tier instances"
  type        = string
  default     = "t2.micro"
}

variable "app_instance_type" {
  description = "EC2 instance type for application tier instances"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name for EC2 instance access (optional)"
  type        = string
  default     = ""
}

# Auto Scaling Configuration
variable "web_min_size" {
  description = "Minimum number of instances in web tier auto scaling group"
  type        = number
  default     = 2
}

variable "web_max_size" {
  description = "Maximum number of instances in web tier auto scaling group"
  type        = number
  default     = 4
}

variable "web_desired_capacity" {
  description = "Desired number of instances in web tier auto scaling group"
  type        = number
  default     = 2
}

variable "app_min_size" {
  description = "Minimum number of instances in application tier auto scaling group"
  type        = number
  default     = 2
}

variable "app_max_size" {
  description = "Maximum number of instances in application tier auto scaling group"
  type        = number
  default     = 4
}

variable "app_desired_capacity" {
  description = "Desired number of instances in application tier auto scaling group"
  type        = number
  default     = 2
}

# Database Configuration - RDS PostgreSQL
variable "db_instance_class" {
  description = "RDS instance class for PostgreSQL database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Master username for PostgreSQL database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for PostgreSQL database"
  type        = string
  sensitive   = true
  default     = "TempPassword123!"
}

variable "db_name" {
  description = "Initial database name for the application"
  type        = string
  default     = "appdb"
}

# Application Configuration
variable "app_port" {
  description = "Port number on which the backend application listens"
  type        = number
  default     = 4000
}

variable "web_port" {
  description = "Port number on which the web server listens"
  type        = number
  default     = 80
}

# Monitoring Configuration
variable "alarm_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
  default     = ""
}