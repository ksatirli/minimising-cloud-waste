# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs#schema
variable "datadog_api_key" {
  type        = string
  description = "Datadog API key."
  sensitive   = true
}

# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs#schema
variable "datadog_app_key" {
  type        = string
  description = "Datadog App key."
  sensitive   = true
}

# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs#schema
variable "datadog_base_url" {
  type        = string
  description = "Datadog base hostname."
  default     = "datadoghq.com"
}

# see https://www.terraform.io/docs/language/values/locals.html
locals {
  api_url = "https://api.${var.datadog_base_url}"
  www_url = "https://www.${var.datadog_base_url}"
}
