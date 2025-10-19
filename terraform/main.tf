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

# Local values for reusable configurations across the project
locals {
  # Select first 2 availability zones for multi-AZ deployment
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
  
  # Common tags applied to all resources for cost tracking and management
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = var.owner
    Component   = "infrastructure"
  }
}