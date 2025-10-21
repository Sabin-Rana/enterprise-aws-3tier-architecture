# ==============================================================================
# SECURITY GROUP MODULE OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines output values for the security group module
# Outputs provide security group information for integration with other modules
# ==============================================================================

# Security Group Outputs
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.main.id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = aws_security_group.main.arn
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.main.name
}

# Rule Outputs
output "ingress_rule_ids" {
  description = "List of ingress rule IDs"
  value       = aws_security_group_rule.ingress[*].id
}

output "egress_rule_ids" {
  description = "List of egress rule IDs"
  value       = aws_security_group_rule.egress[*].id
}