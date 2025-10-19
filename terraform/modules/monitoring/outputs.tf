# monitoring/outputs.tf - Output values for monitoring module

output "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alert notifications"
  value       = aws_sns_topic.alerts.arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.name
}

output "vpc_flow_log_id" {
  description = "ID of the VPC Flow Log for network traffic monitoring"
  value       = aws_flow_log.vpc_flow_log.id
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group for VPC flow logs"
  value       = aws_cloudwatch_log_group.vpc_flow_log.arn
}

output "high_cpu_web_alarm_arn" {
  description = "ARN of the CloudWatch alarm for Web Tier high CPU"
  value       = aws_cloudwatch_metric_alarm.high_cpu_web.arn
}

output "high_cpu_app_alarm_arn" {
  description = "ARN of the CloudWatch alarm for App Tier high CPU"
  value       = aws_cloudwatch_metric_alarm.high_cpu_app.arn
}

output "db_high_cpu_alarm_arn" {
  description = "ARN of the CloudWatch alarm for RDS high CPU"
  value       = aws_cloudwatch_metric_alarm.db_high_cpu.arn
}

output "alb_5xx_errors_alarm_arn" {
  description = "ARN of the CloudWatch alarm for ALB 5xx errors"
  value       = aws_cloudwatch_metric_alarm.alb_5xx_errors.arn
}

output "monitoring_setup_complete" {
  description = "Confirmation that monitoring setup is complete"
  value       = "✅ Monitoring module deployed with CloudWatch dashboard, SNS alerts, and VPC Flow Logs"
}