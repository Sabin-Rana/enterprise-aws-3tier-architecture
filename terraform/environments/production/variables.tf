# Project Configuration
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "enterprise-aws-3tier"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
  default     = "Sabin Rana"
}

# AWS Configuration
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

# Network Configuration
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "Private application subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "Private database subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "app_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 4000
}

# Database Configuration
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
  default     = "TempPassword123!"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

# ------------------------------------------------------------------------------
# COMPUTE TIER VARIABLES
# ------------------------------------------------------------------------------

# AMI ID for EC2 instances
variable "ami_id" {
  description = "AMI ID for EC2 instances - default is Amazon Linux 2"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1
}

# EC2 instance type for application tier
variable "app_instance_type" {
  description = "EC2 instance type for application tier"
  type        = string
  default     = "t2.micro"
}

# SSH key pair name (optional - SSM preferred)
variable "key_name" {
  description = "SSH key pair name for EC2 instances"
  type        = string
  default     = ""
}

# Auto Scaling configuration for application tier
variable "app_min_size" {
  description = "Minimum number of application instances"
  type        = number
  default     = 2
}

variable "app_max_size" {
  description = "Maximum number of application instances"
  type        = number
  default     = 4
}

variable "app_desired_capacity" {
  description = "Desired number of application instances"
  type        = number
  default     = 2
}


