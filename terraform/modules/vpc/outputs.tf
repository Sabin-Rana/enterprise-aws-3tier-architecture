# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# Internet Gateway Output
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

# Subnet Outputs
output "public_subnets" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_app_subnets" {
  description = "IDs of the private application subnets"
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnets" {
  description = "IDs of the private database subnets"
  value       = aws_subnet.private_db[*].id
}

output "public_subnet_cidr_blocks" {
  description = "CIDR blocks of the public subnets"
  value       = aws_subnet.public[*].cidr_block
}

output "private_app_subnet_cidr_blocks" {
  description = "CIDR blocks of the private application subnets"
  value       = aws_subnet.private_app[*].cidr_block
}

output "private_db_subnet_cidr_blocks" {
  description = "CIDR blocks of the private database subnets"
  value       = aws_subnet.private_db[*].cidr_block
}

# Availability Zone Information
output "availability_zones" {
  description = "List of availability zones used by subnets"
  value       = aws_subnet.public[*].availability_zone
}

# Complete Subnet Details (for complex routing)
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
  description = "IDs of the private application route tables"
  value       = aws_route_table.private_app[*].id
}

output "private_db_route_table_ids" {
  description = "IDs of the private database route tables"
  value       = aws_route_table.private_db[*].id
}

output "public_route_table_associations" {
  description = "IDs of public route table associations"
  value       = aws_route_table_association.public[*].id
}

output "private_app_route_table_associations" {
  description = "IDs of private application route table associations"
  value       = aws_route_table_association.private_app[*].id
}

output "private_db_route_table_associations" {
  description = "IDs of private database route table associations"
  value       = aws_route_table_association.private_db[*].id
}

# NAT Gateway Outputs
output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_public_ips" {
  description = "Public IP addresses of the NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "nat_eip_ids" {
  description = "IDs of the Elastic IPs for NAT Gateways"
  value       = aws_eip.nat[*].id
}