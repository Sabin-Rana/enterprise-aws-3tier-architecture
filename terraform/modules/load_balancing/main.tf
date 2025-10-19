# ==============================================================================
# LOAD BALANCING MODULE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This module creates application load balancers and target groups
# Provides traffic distribution and health monitoring for application tier
# ==============================================================================

# Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = "${var.project_name}-app-alb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets           = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-alb"
    Tier = var.internal ? "internal" : "external"
  })
}

# Target Group for application instances
resource "aws_lb_target_group" "app_tg" {
  name     = "${var.project_name}-app-tg"
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

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-tg"
  })
}

# Load Balancer Listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  # Default Forward Action
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-listener"
  })
}