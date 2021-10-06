# The `datadog_dashboard_json` resource is a great way of importing dashboards
# into Datadog when you _only_ have access to a JSON export of the configuration.
#
# This resource is NOT used as part of the webinar
#
# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard_json
#resource "datadog_dashboard_json" "aws_ec2_cost_optimiser" {
#  dashboard = file("./templates/AWS_EC2_Cost_Optimiser.json")
#}
