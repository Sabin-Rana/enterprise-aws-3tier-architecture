# Web Tier Security Group ID - for use by web tier Auto Scaling Group
output "web_tier_sg_id" {
  description = "ID of the web tier security group"
  value       = aws_security_group.web_tier.id
}

# Application Tier Security Group ID - for use by app tier Auto Scaling Group
output "app_tier_sg_id" {
  description = "ID of the application tier security group"
  value       = aws_security_group.app_tier.id
}

# Database Tier Security Group ID - for use by RDS database
output "db_tier_sg_id" {
  description = "ID of the database tier security group"
  value       = aws_security_group.db_tier.id
}

# All security group IDs as a map - for easy reference
output "all_security_group_ids" {
  description = "Map of all security group IDs"
  value = {
    web = aws_security_group.web_tier.id
    app = aws_security_group.app_tier.id
    db  = aws_security_group.db_tier.id
  }
}
