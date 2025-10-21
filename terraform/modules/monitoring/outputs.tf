# ==============================================================================
# MONITORING MODULE OUTPUTS - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This file defines output values for the monitoring module
# Outputs provide monitoring resource information and alert configuration
# ==============================================================================

# CloudWatch Dashboard Outputs
output "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}

output "cloudwatch_dashboard_arn" {
  description = "ARN of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.main.dashboard_arn
}

# SNS Topic Outputs
output "sns_topic_arn" {
  description = "ARN of the SNS topic for alert notifications"
  value       = aws_sns_topic.alerts.arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.name
}

# CloudWatch Alarm Outputs
output "high_cpu_web_alarm_arn" {
  description = "ARN of the web tier high CPU alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu_web.arn
}

output "high_cpu_app_alarm_arn" {
  description = "ARN of the application tier high CPU alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu_app.arn
}

output "db_high_cpu_alarm_arn" {
  description = "ARN of the database high CPU alarm"
  value       = aws_cloudwatch_metric_alarm.db_high_cpu.arn
}

output "alb_5xx_errors_alarm_arn" {
  description = "ARN of the ALB 5xx errors alarm"
  value       = aws_cloudwatch_metric_alarm.alb_5xx_errors.arn
}

# Monitoring Status Output
output "monitoring_setup_complete" {
  description = "Confirmation message for monitoring setup completion"
  value       = "Monitoring module deployed with CloudWatch dashboard and SNS alerts"
}