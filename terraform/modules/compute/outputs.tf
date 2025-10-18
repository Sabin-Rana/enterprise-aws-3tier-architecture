output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.app_launch_template.id
}

output "launch_template_name" {
  description = "Name of the launch template"
  value       = aws_launch_template.app_launch_template.name
}

output "launch_template_latest_version" {
  description = "Latest version of the launch template"
  value       = aws_launch_template.app_launch_template.latest_version
}