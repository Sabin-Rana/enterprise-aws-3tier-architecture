# Web Tier Security Group - Allows HTTP/HTTPS from internet and SSH from anywhere (for troubleshooting)
resource "aws_security_group" "web_tier" {
  name        = "${var.project_name}-web-tier"
  description = "Security group for web tier instances"
  vpc_id      = var.vpc_id

  # Allow HTTP from internet
  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS from internet  
  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH from anywhere (for troubleshooting - restrict in production)
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound"
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

# Application Tier Security Group - Allows traffic only from Web Tier and internal ALB
resource "aws_security_group" "app_tier" {
  name        = "${var.project_name}-app-tier"
  description = "Security group for application tier instances"
  vpc_id      = var.vpc_id

  # Allow application port from Web Tier Security Group
  ingress {
    description     = "Application port from Web Tier"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }

  # Allow SSH from Web Tier (for troubleshooting)
  ingress {
    description     = "SSH from Web Tier"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound"
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

# Database Tier Security Group - Allows traffic only from Application Tier
resource "aws_security_group" "db_tier" {
  name        = "${var.project_name}-db-tier"
  description = "Security group for database tier"
  vpc_id      = var.vpc_id

  # Allow PostgreSQL from Application Tier Security Group only
  ingress {
    description     = "PostgreSQL from Application Tier"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_tier.id]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound"
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