# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Subnet Outputs
output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "private_app_subnet_ids" {
  description = "IDs of the private application subnets"
  value       = module.vpc.private_subnets
}

output "private_db_subnet_ids" {
  description = "IDs of the private database subnets"
  value       = module.vpc.database_subnets
}

# Load Balancer Outputs
output "external_alb_dns_name" {
  description = "DNS name of the external Application Load Balancer"
  value       = module.external_alb.lb_dns_name
}

output "internal_alb_dns_name" {
  description = "DNS name of the internal Application Load Balancer"
  value       = module.internal_alb.lb_dns_name
}

# Auto Scaling Group Outputs
output "web_asg_name" {
  description = "Name of the Web Tier Auto Scaling Group"
  value       = module.web_asg.autoscaling_group_name
}

output "app_asg_name" {
  description = "Name of the Application Tier Auto Scaling Group"
  value       = module.app_asg.autoscaling_group_name
}

# Database Outputs
output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "rds_database_name" {
  description = "Name of the initial database"
  value       = module.rds.db_instance_name
}

# Security Group Outputs
output "web_security_group_id" {
  description = "ID of the web tier security group"
  value       = module.web_sg.security_group_id
}

output "app_security_group_id" {
  description = "ID of the application tier security group"
  value       = module.app_sg.security_group_id
}

output "db_security_group_id" {
  description = "ID of the database tier security group"
  value       = module.db_sg.security_group_id
}

# S3 Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket for application code"
  value       = module.s3_bucket.s3_bucket_id
}

# CloudFront Outputs
output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_domain_name
}

# Monitoring Outputs
output "sns_topic_arn" {
  description = "ARN of the SNS topic for notifications"
  value       = module.monitoring.sns_topic_arn
}

# Application Access Information
output "application_url" {
  description = "URL to access the application"
  value       = "http://${module.external_alb.lb_dns_name}"
}

output "cloudfront_url" {
  description = "URL to access via CloudFront"
  value       = "https://${module.cloudfront.cloudfront_domain_name}"
}

# Instructions Output
output "setup_instructions" {
  description = "Instructions for next steps after deployment"
  value       = <<EOT

Enterprise AWS 3-Tier Architecture Deployment Complete!

Next Steps:
1. Access your application: http://${module.external_alb.lb_dns_name}
2. Check CloudFront URL: https://${module.cloudfront.cloudfront_domain_name}
3. Database endpoint: ${module.rds.db_instance_endpoint}
4. Monitor resources in AWS Console
5. Run 'terraform destroy' when finished to avoid charges

Remember to destroy resources after testing to minimize costs.
EOT
}