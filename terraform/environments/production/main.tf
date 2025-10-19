# ==============================================================================
# PRODUCTION ENVIRONMENT - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines the production environment infrastructure configuration
# It integrates all Terraform modules to create the complete 3-tier architecture
# ==============================================================================

# VPC Module - Core networking foundation
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  common_tags  = local.common_tags
  vpc_cidr     = var.vpc_cidr

  availability_zones = local.azs

  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
}

# Security Groups Module - Layered security architecture
module "security" {
  source = "../../modules/security"

  vpc_id      = module.vpc.vpc_id
  project_name = var.project_name
  common_tags = local.common_tags
  app_port    = var.app_port
}

# Database Module - RDS PostgreSQL with high availability
module "database" {
  source = "../../modules/database"

  project_name = var.project_name
  common_tags  = local.common_tags

  db_instance_class = var.db_instance_class
  db_username       = var.db_username
  db_password       = var.db_password
  db_name           = var.db_name

  private_db_subnet_ids = module.vpc.private_db_subnets
  db_security_group_id  = module.security.db_tier_sg_id
}

# Compute Module - Application tier auto scaling group
module "app_compute" {
  source = "../../modules/compute"

  project_name = var.project_name
  common_tags  = local.common_tags

  ami_id        = var.ami_id
  instance_type = var.app_instance_type
  key_name      = var.key_name

  app_security_group_id    = module.security.app_tier_sg_id
  iam_instance_profile_name = aws_iam_instance_profile.app_instance_profile.name

  min_size         = var.app_min_size
  max_size         = var.app_max_size
  desired_capacity = var.app_desired_capacity

  private_subnet_ids = module.vpc.private_app_subnets
  target_group_arns = [module.internal_alb.target_group_arn]
}

# Load Balancing Module - Internal application load balancer
module "internal_alb" {
  source = "../../modules/load_balancing"

  project_name = var.project_name
  common_tags  = local.common_tags

  internal                   = true
  alb_security_group_id      = module.security.web_tier_sg_id
  subnet_ids                 = module.vpc.private_app_subnets
  enable_deletion_protection = false

  app_port            = var.app_port
  app_protocol        = "HTTP"
  vpc_id              = module.vpc.vpc_id
  health_check_path   = "/health"

  listener_port     = 80
  listener_protocol = "HTTP"
}

# IAM Instance Profile for EC2 SSM access
resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "${var.project_name}-app-instance-profile"
  role = aws_iam_role.app_instance_role.name

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-app-instance-profile"
  })
}

# IAM Role for EC2 instances
resource "aws_iam_role" "app_instance_role" {
  name = "${var.project_name}-app-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-app-instance-role"
  })
}

# IAM Policy Attachment for SSM access
resource "aws_iam_role_policy_attachment" "ssm_managed_instance" {
  role       = aws_iam_role.app_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Monitoring Module - Comprehensive observability
module "monitoring" {
  source = "../../modules/monitoring"

  project_name = var.project_name
  common_tags  = local.common_tags
  aws_region   = var.aws_region

  vpc_id = module.vpc.vpc_id

  web_asg_name = module.app_compute.autoscaling_group_name
  app_asg_name = module.app_compute.autoscaling_group_name

  external_alb_name = module.internal_alb.alb_dns_name
  internal_alb_name = module.internal_alb.alb_dns_name

  db_instance_id = module.database.rds_endpoint
}