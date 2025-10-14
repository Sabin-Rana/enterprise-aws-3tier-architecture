# Database Module Outputs
output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.postgresql.endpoint
}

output "rds_address" {
  description = "RDS instance address"
  value       = aws_db_instance.postgresql.address
}