# ==============================================================================
# MAIN TERRAFORM CONFIGURATION - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines the core Terraform configuration including:
# - Required providers and versions
# - AWS provider configuration with default tags
# - Data sources for availability zones
# - Local values for common configurations
# ==============================================================================

# Terraform block defining required version and providers
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider configuration with default tagging
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = var.owner
      Component   = "infrastructure"
    }
  }
}

# Data source to fetch available AWS availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# ==============================================================================
# VPC MODULE - Network Foundation
# ==============================================================================
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr                = var.vpc_cidr
  project_name            = var.project_name
  environment             = var.environment
  availability_zones      = local.azs
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs = var.private_db_subnet_cidrs
}

# ==============================================================================
# SECURITY GROUPS
# ==============================================================================
module "web_security_group" {
  source = "../../modules/security-group"

  name        = "${var.project_name}-${var.environment}-web-sg"
  description = "Security group for web tier"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP from internet"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS from internet"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = "Allow SSH from VPC"
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]

  tags = local.common_tags
}

module "app_security_group" {
  source = "../../modules/security-group"

  name        = "${var.project_name}-${var.environment}-app-sg"
  description = "Security group for app tier"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = var.app_port
      to_port     = var.app_port
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = "Allow app traffic from web tier"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = "Allow SSH from VPC"
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]

  tags = local.common_tags
}

module "db_security_group" {
  source = "../../modules/security-group"

  name        = "${var.project_name}-${var.environment}-db-sg"
  description = "Security group for database tier"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = var.private_app_subnet_cidrs
      description = "Allow PostgreSQL from app tier"
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]

  tags = local.common_tags
}

# ==============================================================================
# LOAD BALANCERS
# ==============================================================================
module "external_alb" {
  source = "../../modules/load_balancing"

  name               = "${var.project_name}-${var.environment}-ext-alb"
  internal           = false
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  alb_security_group_id = module.web_security_group.security_group_id
  app_port           = var.web_port
  health_check_path  = "/"
  
  tags = local.common_tags
}

module "internal_alb" {
  source = "../../modules/load_balancing"

  name               = "${var.project_name}-${var.environment}-int-alb"
  internal           = true
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_app_subnets
  alb_security_group_id = module.app_security_group.security_group_id
  app_port           = var.app_port
  health_check_path  = "/health"
  
  tags = local.common_tags
}

# ==============================================================================
# COMPUTE MODULE - Web Tier
# ==============================================================================
module "web_compute" {
  source = "../../modules/compute"

  project_name        = var.project_name
  environment         = var.environment
  tier                = "web"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.public_subnets
  instance_type       = var.web_instance_type
  ami_id              = var.ami_id
  key_name            = var.key_name
  min_size            = var.web_min_size
  max_size            = var.web_max_size
  desired_capacity    = var.web_desired_capacity
  
  # Simple inline user data instead of templatefile
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Web Tier - ${var.environment}</h1>" > /var/www/html/index.html
              echo "<p>Listening on port ${var.app_port}</p>" >> /var/www/html/index.html
              EOF
  )

  app_security_group_id = module.web_security_group.security_group_id
  target_group_arns     = [module.external_alb.target_group_arn]
  iam_instance_profile_name = "AmazonSSMManagedInstanceCore"
}

# ==============================================================================
# COMPUTE MODULE - App Tier
# ==============================================================================
module "app_compute" {
  source = "../../modules/compute"

  project_name        = var.project_name
  environment         = var.environment
  tier                = "app"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_app_subnets
  instance_type       = var.app_instance_type
  ami_id              = var.ami_id
  key_name            = var.key_name
  min_size            = var.app_min_size
  max_size            = var.app_max_size
  desired_capacity    = var.app_desired_capacity
  
  # Simple inline user data instead of templatefile
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nodejs npm
              
              # Environment variables
              export APP_PORT=${var.app_port}
              export DB_ENDPOINT=${module.database.rds_endpoint}
              export DB_NAME=${var.db_name}
              export DB_USERNAME=${var.db_username}
              export DB_PASSWORD=${var.db_password}
              
              echo "App Tier configured for ${var.environment}"
              EOF
  )

  app_security_group_id = module.app_security_group.security_group_id
  target_group_arns     = [module.internal_alb.target_group_arn]
  iam_instance_profile_name = "AmazonSSMManagedInstanceCore"
}

# ==============================================================================
# DATABASE MODULE - RDS
# ==============================================================================
module "database" {
  source = "../../modules/database"

  project_name          = var.project_name
  environment           = var.environment
  db_instance_class     = var.db_instance_class
  db_username           = var.db_username
  db_password           = var.db_password
  db_name               = var.db_name
  private_db_subnet_ids = module.vpc.private_db_subnets
  db_security_group_id  = module.db_security_group.security_group_id
  
  tags = local.common_tags
}

# ==============================================================================
# MONITORING MODULE
# ==============================================================================
module "monitoring" {
  source = "../../modules/monitoring"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  web_asg_name      = module.web_compute.autoscaling_group_name
  app_asg_name      = module.app_compute.autoscaling_group_name
  external_alb_name = module.external_alb.alb_name
  internal_alb_name = module.internal_alb.alb_name
  db_instance_id    = module.database.db_instance_identifier
  alarm_email       = var.alarm_email
  
  tags = local.common_tags
}