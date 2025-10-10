# Local values for production environment
locals {
  azs = ["us-east-2a", "us-east-2b"]
  
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = var.owner
  }
}