# ==============================================================================
# COMPUTE MODULE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This module creates EC2 launch templates and auto scaling groups
# Provides scalable compute capacity for the application tier with health monitoring
# ==============================================================================

# EC2 Launch Template for application instances
resource "aws_launch_template" "app_launch_template" {
  name_prefix = "${var.project_name}-app-"
  
  # Instance Configuration
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  # Security Configuration
  vpc_security_group_ids = [var.app_security_group_id]
  
  # User Data Configuration
  user_data = base64encode(var.user_data)
  
  # IAM Configuration
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }
  
  # Instance Tagging
  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.project_name}-app-instance"
      Tier = "application"
    })
  }

  # Launch Template Tagging
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-launch-template"
  })
}

# Auto Scaling Group for application tier
resource "aws_autoscaling_group" "app_asg" {
  name_prefix = "${var.project_name}-app-asg-"

  # Scaling Configuration
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  # Network Configuration
  vpc_zone_identifier = var.private_subnet_ids

  # Load Balancer Integration
  target_group_arns = var.target_group_arns

  # Launch Template Configuration
  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }

  # Health Check Configuration
  health_check_type         = "ELB"
  health_check_grace_period = 300

  # Instance Tagging
  tag {
    key                 = "Name"
    value               = "${var.project_name}-app-instance"
    propagate_at_launch = true
  }

  # Dynamic Common Tagging
  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  # Lifecycle Configuration
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }
}