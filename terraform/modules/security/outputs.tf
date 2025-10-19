# ==============================================================================
# SECURITY MODULE OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines output values for the security module
# Outputs provide security group IDs for integration with other modules
# ==============================================================================

# Individual Security Group Outputs
output "web_tier_sg_id" {
  description = "ID of the web tier security group"
  value       = aws_security_group.web_tier.id
}

output "app_tier_sg_id" {
  description = "ID of the application tier security group"
  value       = aws_security_group.app_tier.id
}

output "db_tier_sg_id" {
  description = "ID of the database tier security group"
  value       = aws_security_group.db_tier.id
}

# Consolidated Security Group Output
output "all_security_group_ids" {
  description = "Map of all security group IDs for easy reference"
  value = {
    web = aws_security_group.web_tier.id
    app = aws_security_group.app_tier.id
    db  = aws_security_group.db_tier.id
  }
}