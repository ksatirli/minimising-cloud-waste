# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs
provider "datadog" {
  api_key  = var.datadog_api_key
  api_url  = local.api_url
  app_key  = var.datadog_app_key
  validate = true
}
