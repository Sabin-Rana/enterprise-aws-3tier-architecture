# Database Configuration Variables
variable "db_instance_class" {
  description = "RDS instance class for PostgreSQL"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

# Security Group Integration
variable "db_security_group_id" {
  description = "Security group ID for database access control"
  type        = string
}

# Network Configuration
variable "private_db_subnet_ids" {
  description = "List of private database subnet IDs"
  type        = list(string)
}

# Project Configuration
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}