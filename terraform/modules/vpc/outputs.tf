# ==============================================================================
# VPC MODULE OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines output values for the VPC module
# Outputs provide essential networking information for other modules
# ==============================================================================

# VPC Information Outputs
output "vpc_id" {
  description = "ID of the main VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the main VPC"
  value       = aws_vpc.main.cidr_block
}

# Internet Gateway Output
output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.main.id
}

# Subnet ID Outputs
output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_app_subnets" {
  description = "List of private application subnet IDs"
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnets" {
  description = "List of private database subnet IDs"
  value       = aws_subnet.private_db[*].id
}

# Subnet CIDR Outputs
output "public_subnet_cidr_blocks" {
  description = "List of public subnet CIDR blocks"
  value       = aws_subnet.public[*].cidr_block
}

output "private_app_subnet_cidr_blocks" {
  description = "List of private application subnet CIDR blocks"
  value       = aws_subnet.private_app[*].cidr_block
}

output "private_db_subnet_cidr_blocks" {
  description = "List of private database subnet CIDR blocks"
  value       = aws_subnet.private_db[*].cidr_block
}

# Availability Zone Information
output "availability_zones" {
  description = "List of availability zones used by subnets"
  value       = aws_subnet.public[*].availability_zone
}