# ==============================================================================
# DATABASE MODULE OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines output values for the database module
# Outputs provide database connection information for application integration
# ==============================================================================

# Database Connection Outputs
output "rds_endpoint" {
  description = "Full database connection endpoint (hostname:port)"
  value       = aws_db_instance.postgresql.endpoint
}

output "rds_address" {
  description = "Database hostname address for application connections"
  value       = aws_db_instance.postgresql.address
}