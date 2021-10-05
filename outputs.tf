# see https://www.terraform.io/docs/language/values/outputs.html
output "url_my_dashboards" {
  description = "URL for all dashboards created by current user"
  value       = "${local.www_url}/dashboard/lists/preset/4"
}

output "url_cost_control_dashboard" {
  description = "URL for Cost Control dashboard"
  value       = "${local.www_url}${datadog_dashboard.aws_ec2_cost_optimiser.url}"
}
