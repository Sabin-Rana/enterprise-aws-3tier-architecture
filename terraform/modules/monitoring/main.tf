# ==============================================================================
# MONITORING MODULE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This module creates comprehensive monitoring and alerting for the 3-tier architecture
# Includes CloudWatch dashboards, SNS alerts, and VPC flow logs for observability
# ==============================================================================

# CloudWatch Dashboard for 3-tier architecture overview
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      # Widget 1: EC2 CPU Utilization (Web & App Tiers)
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.web_asg_name],
            [".", ".", ".", var.app_asg_name, { yAxis = "right" }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "EC2 CPU Utilization (Web & App Tiers)"
          period  = 300
        }
      },

      # Widget 2: ALB Metrics (Health & Requests)
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "LoadBalancer", var.external_alb_name],
            [".", "UnHealthyHostCount", ".", ".", { yAxis = "right" }],
            [".", "RequestCount", ".", ".", { yAxis = "right", stat = "Sum" }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "ALB Health & Requests"
        }
      },

      # Widget 3: RDS Performance Metrics
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", var.db_instance_id],
            [".", "DatabaseConnections", ".", ".", { yAxis = "right" }],
            [".", "FreeStorageSpace", ".", ".", { yAxis = "right" }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "RDS Performance Metrics"
        }
      },

      # Widget 4: Auto Scaling Group Instances
      {
        type   = "metric"
        x      = 8
        y      = 6
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/AutoScaling", "GroupInServiceInstances", "AutoScalingGroupName", var.web_asg_name],
            [".", ".", ".", var.app_asg_name, { label = "App Tier Instances" }]
          ]
          view   = "singleValue"
          region = var.aws_region
          title  = "Auto Scaling Group Instances"
          period = 300
        }
      }
    ]
  })
}

# SNS Topic for alert notifications
resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-alerts"

  tags = merge(var.tags, {
    Name = "${var.project_name}-alerts-topic"
  })
}

# CloudWatch Alarm: Web Tier High CPU
resource "aws_cloudwatch_metric_alarm" "high_cpu_web" {
  alarm_name          = "${var.project_name}-high-cpu-web"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Web tier EC2 CPU utilization exceeded 80%"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    AutoScalingGroupName = var.web_asg_name
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-high-cpu-web-alarm"
  })
}

# CloudWatch Alarm: App Tier High CPU
resource "aws_cloudwatch_metric_alarm" "high_cpu_app" {
  alarm_name          = "${var.project_name}-high-cpu-app"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "App tier EC2 CPU utilization exceeded 80%"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    AutoScalingGroupName = var.app_asg_name
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-high-cpu-app-alarm"
  })
}

# CloudWatch Alarm: Database High CPU
resource "aws_cloudwatch_metric_alarm" "db_high_cpu" {
  alarm_name          = "${var.project_name}-db-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 75
  alarm_description   = "RDS CPU utilization exceeded 75%"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-db-high-cpu-alarm"
  })
}

# CloudWatch Alarm: ALB 5xx Errors
resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  alarm_name          = "${var.project_name}-alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "ALB 5XX errors exceeded threshold"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = var.external_alb_name
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-alb-5xx-alarm"
  })
}