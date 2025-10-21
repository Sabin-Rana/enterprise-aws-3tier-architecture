# ==============================================================================
# DATABASE MODULE VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines input variables for the database module configuration
# Variables control database instance type, credentials, and network settings
# ==============================================================================

# Database Instance Configuration
variable "db_instance_class" {
  description = "RDS instance class for PostgreSQL database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Master username for database authentication"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for database authentication"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name for application data"
  type        = string
  default     = "appdb"
}

# Security Configuration
variable "db_security_group_id" {
  description = "Security group ID for database network access control"
  type        = string
}

# Network Configuration
variable "private_db_subnet_ids" {
  description = "List of private subnet IDs for database deployment"
  type        = list(string)
}

# Project Configuration
variable "project_name" {
  description = "Project name for database resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment for database resource naming and tagging"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all database resources"
  type        = map(string)
  default     = {}
}