# monitoring/variables.tf - Input variables for monitoring module

variable "project_name" {
  description = "Name of the project for resource naming and tagging"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all monitoring resources"
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "AWS region where monitoring resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID of the VPC to monitor with flow logs"
  type        = string
}

variable "web_asg_name" {
  description = "Name of the Web Tier Auto Scaling Group for CPU monitoring"
  type        = string
}

variable "app_asg_name" {
  description = "Name of the Application Tier Auto Scaling Group for CPU monitoring"
  type        = string
}

variable "external_alb_name" {
  description = "Name of the External Application Load Balancer for health monitoring"
  type        = string
}

variable "db_instance_id" {
  description = "ID of the RDS database instance for performance monitoring"
  type        = string
}

variable "internal_alb_name" {
  description = "Name of the Internal Application Load Balancer for health monitoring"
  type        = string
  default     = ""  # Optional since we might not always have internal ALB
}