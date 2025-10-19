# ==============================================================================
# VPC NAT GATEWAYS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines NAT gateways and routing for private subnets
# NAT gateways enable private subnets to access the internet for updates
# ==============================================================================

# Elastic IP addresses for NAT gateways
resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidrs)
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-nat-eip-${count.index + 1}"
    }
  )
}

# NAT gateways deployed in public subnets
resource "aws_nat_gateway" "main" {
  count = length(var.public_subnet_cidrs)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-nat-gateway-${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# NAT gateway routes for private application subnets
resource "aws_route" "private_app_nat" {
  count = length(aws_route_table.private_app)

  route_table_id         = aws_route_table.private_app[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
}

# NAT gateway routes for private database subnets
resource "aws_route" "private_db_nat" {
  count = length(aws_route_table.private_db)

  route_table_id         = aws_route_table.private_db[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
}