# ==============================================================================
# VPC MODULE VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines input variables for the VPC module configuration
# Variables control VPC CIDR, subnet allocation, and availability zone placement
# ==============================================================================

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the main Virtual Private Cloud"
  type        = string
  default     = "10.0.0.0/16"
}

# Project Configuration
variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all VPC resources"
  type        = map(string)
  default     = {}
}

# Availability Zones Configuration
variable "availability_zones" {
  description = "List of availability zones for multi-AZ deployment"
  type        = list(string)
}

# Subnet CIDR Configuration
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