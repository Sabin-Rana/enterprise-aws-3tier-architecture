# ==============================================================================
# PRODUCTION LOCALS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines local values and calculations for the production environment
# Locals provide computed values and consistent tagging across all resources
# ==============================================================================

# Local values for production environment configuration
locals {
  # Availability zones for multi-AZ deployment
  azs = data.aws_availability_zones.available.names
  
  # Common tags applied to all production resources
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = var.owner
    Component   = "production"
  }
}