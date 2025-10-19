# ==============================================================================
# SECURITY MODULE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This module creates layered security groups for the 3-tier architecture
# Security groups control network traffic between web, app, and database tiers
# ==============================================================================

# Web Tier Security Group - Public facing instances
resource "aws_security_group" "web_tier" {
  name        = "${var.project_name}-web-tier"
  description = "Security group for web tier instances (public facing)"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic from internet
  ingress {
    description = "HTTP access from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic from internet
  ingress {
    description = "HTTPS access from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access for administration
  ingress {
    description = "SSH access for administration"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-web-tier-sg"
    Tier = "web"
  })
}

# Application Tier Security Group - Internal instances
resource "aws_security_group" "app_tier" {
  name        = "${var.project_name}-app-tier"
  description = "Security group for application tier instances (internal)"
  vpc_id      = var.vpc_id

  # Allow application traffic from web tier
  ingress {
    description     = "Application traffic from web tier"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }

  # Allow SSH access from web tier
  ingress {
    description     = "SSH access from web tier"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-tier-sg"
    Tier = "app"
  })
}

# Database Tier Security Group - Database instances
resource "aws_security_group" "db_tier" {
  name        = "${var.project_name}-db-tier"
  description = "Security group for database tier instances"
  vpc_id      = var.vpc_id

  # Allow PostgreSQL traffic from application tier
  ingress {
    description     = "PostgreSQL access from application tier"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_tier.id]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-db-tier-sg"
    Tier = "db"
  })
}