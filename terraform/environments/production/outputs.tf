# ==============================================================================
# PRODUCTION OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines output values for the production environment
# Outputs provide essential connection information and resource identifiers
# ==============================================================================

# VPC and Network Outputs
output "vpc_id" {
  description = "ID of the production VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the production VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs in production"
  value       = module.vpc.public_subnets
}

output "private_app_subnet_ids" {
  description = "List of private application subnet IDs in production"
  value       = module.vpc.private_app_subnets
}

output "private_db_subnet_ids" {
  description = "List of private database subnet IDs in production"
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

output "target_group_arn" {
  description = "ARN of the application target group"
  value       = module.internal_alb.target_group_arn
}

# Compute Outputs
output "web_autoscaling_group_name" {
  description = "Name of the web tier auto scaling group"
  value       = module.web_compute.autoscaling_group_name
}

output "app_autoscaling_group_name" {
  description = "Name of the application tier auto scaling group"
  value       = module.app_compute.autoscaling_group_name
}

output "web_launch_template_id" {
  description = "ID of the web tier launch template"
  value       = module.web_compute.launch_template_id
}

output "app_launch_template_id" {
  description = "ID of the application tier launch template"
  value       = module.app_compute.launch_template_id
}

# Database Outputs
output "rds_endpoint" {
  description = "Connection endpoint for production database"
  value       = module.database.rds_endpoint
}

output "rds_address" {
  description = "Address of the production database"
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
output "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = module.monitoring.cloudwatch_dashboard_name
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = module.monitoring.sns_topic_arn
}

# Application Access Information
output "application_url" {
  description = "URL to access the production application"
  value       = "http://${module.external_alb.alb_dns_name}"
}

# Deployment Information
output "deployment_summary" {
  description = "Production deployment summary and next steps"
  value       = <<EOT

Production Deployment Complete - Enterprise AWS 3-Tier Architecture

Access Points:
- Application URL: http://${module.external_alb.alb_dns_name}
- Database Endpoint: ${module.database.rds_endpoint}

Resource Information:
- Web Auto Scaling Group: ${module.web_compute.autoscaling_group_name}
- App Auto Scaling Group: ${module.app_compute.autoscaling_group_name}
- CloudWatch Dashboard: ${module.monitoring.cloudwatch_dashboard_name}

Next Steps:
1. Verify application functionality
2. Monitor CloudWatch metrics
3. Run database connectivity tests
4. Destroy resources after testing to control costs

EOT
}