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