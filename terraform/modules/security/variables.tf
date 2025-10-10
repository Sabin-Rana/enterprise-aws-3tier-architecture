# VPC ID where security groups will be created
variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

# Project name for resource naming and tagging
variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
}

# Common tags for all resources
variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

# Application port for app tier security group rules
variable "app_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 4000
}

# List of allowed IPs for SSH access (for production hardening)
variable "allowed_ssh_ips" {
  description = "List of IP addresses allowed to SSH into instances"
  type        = list(string)
  default     = ["0.0.0.0/0"] # WARNING: In production, restrict this!
}