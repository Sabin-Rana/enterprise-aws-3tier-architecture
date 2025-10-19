# Production Environment - Enterprise AWS 3-Tier Architecture

module "vpc" {
  source = "../../modules/vpc"

  # Project Configuration
  project_name = var.project_name
  common_tags  = local.common_tags

  # VPC Configuration
  vpc_cidr = var.vpc_cidr

  # Availability Zones
  availability_zones = local.azs

  # Subnet Configuration
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
}

# Security Groups Module - Creates layered security groups for 3-tier architecture
module "security" {
  source = "../../modules/security"

  vpc_id      = module.vpc.vpc_id
  project_name = var.project_name
  common_tags = local.common_tags
  app_port    = var.app_port
}

# Database Tier - RDS PostgreSQL
module "database" {
  source = "../../modules/database"

  project_name = var.project_name
  common_tags  = local.common_tags

  # Database Configuration
  db_instance_class = var.db_instance_class
  db_username       = var.db_username
  db_password       = var.db_password
  db_name           = var.db_name

  # Network Configuration
  private_db_subnet_ids = module.vpc.private_db_subnets
  db_security_group_id  = module.security.db_tier_sg_id
}

# ------------------------------------------------------------------------------
# COMPUTE MODULE - APPLICATION TIER
# ------------------------------------------------------------------------------
# Creates Auto Scaling Group and EC2 instances for the application tier
module "app_compute" {
  source = "../../modules/compute"

  project_name = var.project_name
  common_tags  = local.common_tags

  # Instance configuration
  ami_id        = var.ami_id
  instance_type = var.app_instance_type
  key_name      = var.key_name

  # Security configuration
  app_security_group_id    = module.app_security.app_tier_sg_id
  iam_instance_profile_name = aws_iam_instance_profile.app_instance_profile.name

  # Auto Scaling configuration
  min_size         = var.app_min_size
  max_size         = var.app_max_size
  desired_capacity = var.app_desired_capacity

  # Networking
  private_subnet_ids = module.vpc.private_app_subnets

  # Load balancer integration (will be added after creating ALB)
  target_group_arns = [module.internal_alb.target_group_arn]
}

# ------------------------------------------------------------------------------
# LOAD BALANCING MODULE - INTERNAL ALB
# ------------------------------------------------------------------------------
# Creates internal Application Load Balancer for application tier
module "internal_alb" {
  source = "../../modules/load_balancing"

  project_name = var.project_name
  common_tags  = local.common_tags

  # ALB Configuration - internal for application tier
  internal                   = true
  alb_security_group_id      = module.app_security.web_tier_sg_id
  subnet_ids                 = module.vpc.private_app_subnets
  enable_deletion_protection = false

  # Target Group Configuration
  app_port            = var.app_port
  app_protocol        = "HTTP"
  vpc_id              = module.vpc.vpc_id
  health_check_path   = "/health"

  # Listener Configuration
  listener_port     = 80
  listener_protocol = "HTTP"
}

# ------------------------------------------------------------------------------
# SECURITY MODULE - SECURITY GROUPS
# ------------------------------------------------------------------------------
# Creates security groups for all tiers of the architecture
module "app_security" {
  source = "../../modules/security"

  project_name = var.project_name
  common_tags  = local.common_tags

  # VPC configuration
  vpc_id = module.vpc.vpc_id

  # Application port for security group rules
  app_port = var.app_port
}

# ------------------------------------------------------------------------------
# IAM INSTANCE PROFILE
# ------------------------------------------------------------------------------
# Enables EC2 instances to use SSM Session Manager for secure access
resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "${var.project_name}-app-instance-profile"
  role = aws_iam_role.app_instance_role.name

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-app-instance-profile"
  })
}

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

resource "aws_iam_role_policy_attachment" "ssm_managed_instance" {
  role       = aws_iam_role.app_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Monitoring Module - Comprehensive observability for 3-tier architecture
module "monitoring" {
  source = "../../modules/monitoring"

  project_name = var.project_name
  common_tags  = local.common_tags
  aws_region   = var.aws_region

  # VPC for flow logs
  vpc_id = module.vpc.vpc_id

  # Auto Scaling Groups for CPU monitoring
  web_asg_name = module.app_compute.autoscaling_group_name
  app_asg_name = module.app_compute.autoscaling_group_name

  # Load Balancers for health monitoring
  external_alb_name = module.internal_alb.alb_dns_name
  internal_alb_name = module.internal_alb.alb_dns_name

  # Database for performance monitoring
  db_instance_id = module.database.rds_endpoint
}