# RDS PostgreSQL Database Module - Enterprise AWS 3-Tier Architecture

# Database Subnet Group for Multi-AZ Deployment
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids
  
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

# RDS PostgreSQL Instance - Production Ready with Cost Optimization
resource "aws_db_instance" "postgresql" {
  identifier = "${var.project_name}-db"

  # Database Engine Configuration
  engine               = "postgres"
  engine_version       = "14.9"
  instance_class       = var.db_instance_class
  allocated_storage    = 20
  storage_type         = "gp2"
  max_allocated_storage = 50

  # Database Credentials
  username = var.db_username
  password = var.db_password
  db_name  = var.db_name

  # Network & Security
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_security_group_id]
  publicly_accessible    = false
  port                   = 5432

  # High Availability & Backup
  multi_az               = true
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  # Performance & Monitoring
  storage_encrypted      = true
  monitoring_interval    = 60
  performance_insights_enabled = true

  # Deletion Protection
  deletion_protection    = false
  skip_final_snapshot    = true

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-rds-postgresql"
  })
}