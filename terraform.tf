terraform {
  # see https://www.terraform.io/docs/language/settings/backends/remote.html
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ksatirli"

    workspaces {
      name = "minimize-cloud-waste"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest
    datadog = {
      source  = "DataDog/datadog"
      version = "3.4.0"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-a-required-terraform-version
  required_version = ">= 1.0.8"
}
