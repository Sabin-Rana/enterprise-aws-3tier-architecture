# ==============================================================================
# LOAD BALANCING MODULE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This module creates application load balancers and target groups
# Provides traffic distribution and health monitoring for application tier
# ==============================================================================

# Application Load Balancer
resource "aws_lb" "main" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = "application"
  security_groups            = [var.alb_security_group_id]
  subnets                    = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(var.tags, {
    Name = var.name
    Tier = var.internal ? "internal" : "external"
  })
}

# Target Group for application instances
resource "aws_lb_target_group" "main" {
  name     = substr("${var.name}-tg", 0, 32)
  port     = var.app_port
  protocol = var.app_protocol
  vpc_id   = var.vpc_id

  # Health Check Configuration
  health_check {
    enabled             = true
    path                = var.health_check_path
    port                = var.app_port
    protocol            = var.app_protocol
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = merge(var.tags, {
    Name = "${var.name}-tg"
  })
}

# Load Balancer Listener
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  # Default Forward Action
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = merge(var.tags, {
    Name = "${var.name}-listener"
  })
}