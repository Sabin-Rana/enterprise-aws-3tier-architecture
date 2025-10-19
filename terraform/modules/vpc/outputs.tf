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

# Subnet Detail Outputs
output "public_subnet_details" {
  description = "Detailed information about public subnets"
  value = {
    for subnet in aws_subnet.public :
    subnet.id => {
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
    }
  }
}

output "private_app_subnet_details" {
  description = "Detailed information about private application subnets"
  value = {
    for subnet in aws_subnet.private_app :
    subnet.id => {
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
    }
  }
}

output "private_db_subnet_details" {
  description = "Detailed information about private database subnets"
  value = {
    for subnet in aws_subnet.private_db :
    subnet.id => {
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
    }
  }
}

# Route Table Outputs
output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_app_route_table_ids" {
  description = "List of private application route table IDs"
  value       = aws_route_table.private_app[*].id
}

output "private_db_route_table_ids" {
  description = "List of private database route table IDs"
  value       = aws_route_table.private_db[*].id
}

# Route Table Association Outputs
output "public_route_table_associations" {
  description = "List of public route table association IDs"
  value       = aws_route_table_association.public[*].id
}

output "private_app_route_table_associations" {
  description = "List of private application route table association IDs"
  value       = aws_route_table_association.private_app[*].id
}

output "private_db_route_table_associations" {
  description = "List of private database route table association IDs"
  value       = aws_route_table_association.private_db[*].id
}

# NAT Gateway Outputs
output "nat_gateway_ids" {
  description = "List of NAT gateway IDs"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_public_ips" {
  description = "List of NAT gateway public IP addresses"
  value       = aws_eip.nat[*].public_ip
}

output "nat_eip_ids" {
  description = "List of NAT gateway Elastic IP IDs"
  value       = aws_eip.nat[*].id
}