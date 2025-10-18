# ==============================================================================
# COMPUTE MODULE - EC2 LAUNCH TEMPLATE & AUTO SCALING GROUP
# ==============================================================================

# This module creates the compute infrastructure for the application tier
# including EC2 launch templates and Auto Scaling Groups for high availability

# ------------------------------------------------------------------------------
# EC2 LAUNCH TEMPLATE
# ------------------------------------------------------------------------------
# Defines the blueprint for EC2 instances in the application tier
# Includes AMI, instance type, security groups, and user data configuration
resource "aws_launch_template" "app_launch_template" {
  # Unique name prefix for the launch template
  name_prefix = "${var.project_name}-app-"
  
  # Instance configuration
  image_id      = var.ami_id                    # Amazon Machine Image ID
  instance_type = var.instance_type             # Instance size (t2.micro, etc.)
  key_name      = var.key_name                  # SSH key pair for access
  
  # Security configuration - attaches instances to application security group
  vpc_security_group_ids = [var.app_security_group_id]
  
  # User data script for instance initialization (base64 encoded)
  user_data = base64encode(var.user_data)
  
  # IAM instance profile for EC2 instances (enables SSM Session Manager)
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }
  
  # Tag specifications for instances created from this template
  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.project_name}-app-instance"  # Instance name
      Tier = "application"                       # Identifies application tier
    })
  }

  # Tags for the launch template itself
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-launch-template"
  })
}

# ------------------------------------------------------------------------------
# AUTO SCALING GROUP
# ------------------------------------------------------------------------------
# Manages the fleet of EC2 instances with automatic scaling based on demand
# Ensures high availability across multiple availability zones
resource "aws_autoscaling_group" "app_asg" {
  # Unique name prefix for the Auto Scaling Group
  name_prefix = "${var.project_name}-app-asg-"

  # Scaling configuration
  min_size         = var.min_size          # Minimum number of instances
  max_size         = var.max_size          # Maximum number of instances  
  desired_capacity = var.desired_capacity  # Desired running instances

  # Network configuration - instances launched in private subnets
  vpc_zone_identifier = var.private_subnet_ids

  # Load balancer integration - registers instances with target groups
  target_group_arns = var.target_group_arns

  # Launch template reference - uses the template defined above
  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"  # Always use the latest version of the template
  }

  # Health check configuration
  health_check_type         = "ELB"        # Use ELB health checks
  health_check_grace_period = 300          # 5 minutes grace period

  # Instance tagging
  tag {
    key                 = "Name"
    value               = "${var.project_name}-app-instance"
    propagate_at_launch = true  # Tag applies to all instances in ASG
  }

  # Dynamic tagging for all common tags
  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  # Lifecycle configuration
  lifecycle {
    create_before_destroy = true    # Ensure new ASG before destroying old
    ignore_changes        = [load_balancers, target_group_arns]  # Prevent drift
  }
}