# ==============================================================================
# LOAD BALANCING MODULE - APPLICATION LOAD BALANCER
# ==============================================================================

# This module creates Application Load Balancers for routing traffic
# to the application tier with health checks and load distribution

# ------------------------------------------------------------------------------
# APPLICATION LOAD BALANCER (ALB)
# ------------------------------------------------------------------------------
# Distributes incoming application traffic across multiple EC2 instances
# Provides health checking and automatic failover for high availability
resource "aws_lb" "app_alb" {
  # Load balancer name for identification in AWS Console
  name               = "${var.project_name}-app-alb"
  
  # Internal (true) for private subnets, External (false) for public subnets
  internal           = var.internal
  
  # Application Load Balancer type (supports HTTP/HTTPS protocols)
  load_balancer_type = "application"
  
  # Security group controlling traffic to/from the load balancer
  security_groups = [var.alb_security_group_id]
  
  # Subnets across multiple AZs for high availability
  subnets         = var.subnet_ids

  # Prevents accidental deletion - set to true in production
  enable_deletion_protection = var.enable_deletion_protection

  # Resource tagging for identification and cost tracking
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-alb"
    Tier = var.internal ? "internal" : "external"  # Identifies ALB type
  })
}

# ------------------------------------------------------------------------------
# TARGET GROUP
# ------------------------------------------------------------------------------
# Defines where the load balancer routes traffic - connects to EC2 instances
# Health checks determine which instances receive traffic
resource "aws_lb_target_group" "app_tg" {
  # Target group name for identification
  name     = "${var.project_name}-app-tg"
  
  # Target group protocol and port - matches application configuration
  port     = var.app_port
  protocol = var.app_protocol
  
  # VPC where targets are located
  vpc_id   = var.vpc_id

  # Health check configuration - determines instance health
  health_check {
    enabled             = true
    path                = var.health_check_path
    port                = var.app_port
    protocol            = var.app_protocol
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"  # HTTP status code for healthy responses
  }

  # Resource tagging for identification
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-tg"
  })
}

# ------------------------------------------------------------------------------
# LISTENER
# ------------------------------------------------------------------------------
# Defines how the load balancer handles incoming traffic
# Routes requests from the ALB to the target group
resource "aws_lb_listener" "app_listener" {
  # Attach listener to the Application Load Balancer
  load_balancer_arn = aws_lb.app_alb.arn
  
  # Listener port and protocol - HTTP for internal, HTTPS for external
  port     = var.listener_port
  protocol = var.listener_protocol

  # Default action - forward all traffic to the target group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  # Resource tagging for identification
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-listener"
  })
}