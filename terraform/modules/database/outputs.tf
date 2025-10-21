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

output "rds_port" {
  description = "Database port number"
  value       = aws_db_instance.postgresql.port
}

output "db_instance_identifier" {
  description = "RDS instance identifier for monitoring"
  value       = aws_db_instance.postgresql.identifier
}

# Database Information Outputs
output "db_subnet_group_name" {
  description = "Name of the database subnet group"
  value       = aws_db_subnet_group.main.name
}

output "db_engine_version" {
  description = "Database engine version"
  value       = aws_db_instance.postgresql.engine_version
}