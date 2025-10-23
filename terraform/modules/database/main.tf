# ==============================================================================
# DATABASE MODULE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This module creates RDS PostgreSQL database with production-ready configuration
# Includes multi-AZ deployment, backups, encryption, and performance monitoring
# ==============================================================================

# Database Subnet Group for multi-AZ deployment
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

# RDS PostgreSQL Database Instance
resource "aws_db_instance" "postgresql" {
  identifier = "${var.project_name}-db"

  # Database Engine Configuration
  engine                = "postgres"
  engine_version        = "14.9"
  instance_class        = var.db_instance_class
  allocated_storage     = 20
  storage_type          = "gp2"
  max_allocated_storage = 50

  # Database Credentials
  username = var.db_username
  password = var.db_password
  db_name  = var.db_name

  # Network and Security Configuration
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_security_group_id]
  publicly_accessible    = false
  port                   = 5432

  # High Availability and Backup Configuration
  multi_az                = true
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  # Performance and Monitoring Configuration
  storage_encrypted            = true
  monitoring_interval          = 60
  performance_insights_enabled = true

  # Deletion Protection Configuration
  deletion_protection = false
  skip_final_snapshot = true

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-rds-postgresql"
  })
}