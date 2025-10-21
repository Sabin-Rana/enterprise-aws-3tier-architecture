# ==============================================================================
# TERRAFORM OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines all output values exposed by the root Terraform configuration
# Outputs provide essential connection information and resource identifiers
# ==============================================================================

# VPC and Network Outputs
output "vpc_id" {
  description = "ID of the main VPC for the 3-tier architecture"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the main VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs for web tier resources"
  value       = module.vpc.public_subnets
}

output "private_app_subnet_ids" {
  description = "List of private application subnet IDs for app tier resources"
  value       = module.vpc.private_app_subnets
}

output "private_db_subnet_ids" {
  description = "List of private database subnet IDs for database tier resources"
  value       = module.vpc.private_db_subnets
}

# Load Balancer Outputs
output "external_alb_dns_name" {
  description = "DNS name of the external application load balancer"
  value       = module.external_alb.alb_dns_name
}

output "internal_alb_dns_name" {
  description = "DNS name of the internal application load balancer"
  value       = module.internal_alb.alb_dns_name
}

# Auto Scaling Group Outputs
output "web_asg_name" {
  description = "Name of the web tier auto scaling group"
  value       = module.web_compute.autoscaling_group_name
}

output "app_asg_name" {
  description = "Name of the application tier auto scaling group"
  value       = module.app_compute.autoscaling_group_name
}

# Database Outputs
output "rds_endpoint" {
  description = "Connection endpoint for the RDS PostgreSQL database"
  value       = module.database.rds_endpoint
}

output "rds_address" {
  description = "Address of the RDS PostgreSQL database"
  value       = module.database.rds_address
}

# Security Group Outputs
output "web_security_group_id" {
  description = "ID of the web tier security group"
  value       = module.web_security_group.security_group_id
}

output "app_security_group_id" {
  description = "ID of the application tier security group"
  value       = module.app_security_group.security_group_id
}

output "db_security_group_id" {
  description = "ID of the database tier security group"
  value       = module.db_security_group.security_group_id
}

# Monitoring Outputs
output "sns_topic_arn" {
  description = "ARN of the SNS topic for monitoring alerts"
  value       = module.monitoring.sns_topic_arn
}

# Application Access Information
output "application_url" {
  description = "URL to access the deployed application"
  value       = "http://${module.external_alb.alb_dns_name}"
}

# Deployment Instructions
output "setup_instructions" {
  description = "Post-deployment instructions and next steps"
  value       = <<EOT

Enterprise AWS 3-Tier Architecture Deployment Complete!

Next Steps:
1. Access your application: http://${module.external_alb.alb_dns_name}
2. Database endpoint: ${module.database.rds_endpoint}
3. Monitor resources in AWS Console
4. Run 'terraform destroy' when finished to minimize costs

Remember to destroy resources after testing to avoid unnecessary charges.
EOT
}