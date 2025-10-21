# ==============================================================================
# SECURITY GROUP MODULE VARIABLES - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines input variables for the security group module configuration
# Variables control security group rules and network access policies
# ==============================================================================

# Security Group Basic Configuration
variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "ID of the VPC where security group will be created"
  type        = string
}

# Ingress Rules Configuration
variable "ingress_rules" {
  description = "List of ingress security group rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

# Egress Rules Configuration
variable "egress_rules" {
  description = "List of egress security group rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

# Tagging Configuration
variable "tags" {
  description = "Tags applied to the security group"
  type        = map(string)
  default     = {}
}