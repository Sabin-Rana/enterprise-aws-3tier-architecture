# ==============================================================================
# VPC ROUTE TABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines route tables and associations for the VPC module
# Route tables control traffic routing between subnets and external networks
# ==============================================================================

# Public Route Table with internet gateway route
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-public-rt"
      Tier = "public"
    }
  )
}

# Public subnet route table associations
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Application Route Tables (one per subnet)
resource "aws_route_table" "private_app" {
  count = length(var.private_app_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-private-app-rt-${count.index + 1}"
      Tier = "private-app"
    }
  )
}

# Private application subnet route table associations
resource "aws_route_table_association" "private_app" {
  count = length(aws_subnet.private_app)

  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app[count.index].id
}

# Private Database Route Tables (one per subnet)
resource "aws_route_table" "private_db" {
  count = length(var.private_db_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-private-db-rt-${count.index + 1}"
      Tier = "private-db"
    }
  )
}

# Private database subnet route table associations
resource "aws_route_table_association" "private_db" {
  count = length(aws_subnet.private_db)

  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private_db[count.index].id
}