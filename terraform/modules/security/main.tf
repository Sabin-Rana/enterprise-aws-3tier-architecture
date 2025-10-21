# ==============================================================================
# SECURITY GROUP MODULE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This module creates security groups with dynamic ingress and egress rules
# Security groups control network traffic between different tiers of the architecture
# ==============================================================================

# Main Security Group resource
resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

# Dynamic ingress rules
resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_rules)

  security_group_id = aws_security_group.main.id
  type              = "ingress"

  description = var.ingress_rules[count.index].description
  from_port   = var.ingress_rules[count.index].from_port
  to_port     = var.ingress_rules[count.index].to_port
  protocol    = var.ingress_rules[count.index].protocol
  cidr_blocks = var.ingress_rules[count.index].cidr_blocks
}

# Dynamic egress rules
resource "aws_security_group_rule" "egress" {
  count = length(var.egress_rules)

  security_group_id = aws_security_group.main.id
  type              = "egress"

  description = var.egress_rules[count.index].description
  from_port   = var.egress_rules[count.index].from_port
  to_port     = var.egress_rules[count.index].to_port
  protocol    = var.egress_rules[count.index].protocol
  cidr_blocks = var.egress_rules[count.index].cidr_blocks
}