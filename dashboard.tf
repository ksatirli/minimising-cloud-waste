# styling options for Dashboard
locals {
  column_title_size = 24

  widget_title_size  = 16
  widget_title_align = "left"

  widget_height_s = 7
  widget_height_m = 15
  widget_height_l = 23

  widget_width_m = 23
  widget_width_l = 47
}

# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard
resource "datadog_dashboard" "aws_ec2_cost_optimiser" {
  # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#optional
  description = <<-EOT
  ## Cloud Cost Optimisation

  This is a companion dashboard for the October 2021 [HashiCorp and Datadog webinar](https://www.datadoghq.com/partner/hashicorp21/) on minimizing Cloud Waste.

  This dashboard uses data from your [AWS Cost and Usage](https://docs.aws.amazon.com/cur/latest/userguide/what-is-cur.html) report.
  EOT
  # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#required
  title        = "AWS EC2 Cost Optimiser"
  layout_type  = "free"
  is_read_only = false

  # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#optional
  template_variable {
    name    = "instance-type"
    default = "*"
    prefix  = "instance-type"
  }

  template_variable {
    name    = "team"
    default = "*"
    prefix  = "team"
  }

  template_variable {
    name    = "app"
    default = "*"
    prefix  = "app"
  }

  template_variable {
    name    = "service"
    default = "*"
    prefix  = "service"
  }

  template_variable {
    name    = "offer-instance-type"
    default = "*"
    prefix  = "offer_instance-type"
  }

  template_variable {
    name    = "offer_region"
    default = "*"
    prefix  = "offer_region"
  }

  template_variable {
    name    = "offer_operating_system"
    default = "*"
    prefix  = "offer_operating_system"
  }

  template_variable {
    name    = "offer_pricing_model"
    default = "*"
    prefix  = "offer_pricing_model"
  }

  template_variable {
    name    = "offer_lease_contract"
    default = "*"
    prefix  = "offer_lease_contract"
  }

  # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widget
  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetnote_definition
    note_definition {
      background_color = "vivid_blue"
      content          = "Instances ($instance-type.value)"
      font_size        = local.column_title_size
      has_padding      = false
      show_tick        = false
      text_align       = "center"
      tick_edge        = "left"
      tick_pos         = "50%"
      vertical_align   = "center"
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_s
      is_column_break = false
      width           = local.widget_width_l
      x               = 0
      y               = 0
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetnote_definition
    note_definition {
      background_color = "vivid_orange"
      content          = "Spend"
      font_size        = local.column_title_size
      has_padding      = false
      show_tick        = false
      text_align       = "center"
      tick_edge        = "left"
      tick_pos         = "50%"
      vertical_align   = "center"
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_s
      is_column_break = false
      width           = local.widget_width_l
      x               = 48
      y               = 0
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetnote_definition
    note_definition {
      background_color = "vivid_green"
      content          = "Potential Optimisation"
      font_size        = local.column_title_size
      has_padding      = false
      show_tick        = false
      text_align       = "center"
      tick_edge        = "left"
      tick_pos         = "50%"
      vertical_align   = "center"
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_s
      is_column_break = false
      width           = local.widget_width_l
      x               = 96
      y               = 0
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetnote_definition
    note_definition {
      background_color = "white"
      content          = "Notes"
      font_size        = local.column_title_size
      has_padding      = false
      show_tick        = false
      text_align       = "center"
      tick_edge        = "left"
      tick_pos         = "50%"
      vertical_align   = "center"
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_s
      is_column_break = false
      width           = local.widget_width_l
      x               = 144
      y               = 0
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetquery_value_definition
    query_value_definition {
      autoscale   = false
      precision   = 0
      title       = "Total Running Instances"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        aggregator = "avg"
        q          = "sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service}"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_m
      x               = 0
      y               = local.widget_height_s + 1
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgettoplist_definition
    toplist_definition {
      title       = "Count of Hosts by Instance Type"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        q = "top(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}, 10, 'last', 'desc')"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 0
      y               = local.widget_height_l + 1
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = [
        "avg",
        "max",
        "min",
        "sum",
        "value",
      ]

      legend_layout = "vertical"
      legend_size   = "0"
      show_legend   = false
      title         = "Cost / Hour - Total Running Instances"
      title_align   = "left"
      title_size    = "16"

      request {
        display_type   = "area"
        on_right_yaxis = false
        q              = "sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}*avg:awscostusagereport.ec2.pricing.current{$instance-type} by {instance-type}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "warm"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 48
      y               = 40
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetquery_value_definition
    query_value_definition {
      autoscale   = true
      custom_unit = "USD"
      precision   = 0
      title       = "Total Compute Spend (Monthly)"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        aggregator = "last"
        q          = "sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service}*avg:awscostusagereport.ec2.pricing.current{$instance-type}*720"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_m
      x               = 48
      y               = local.widget_height_s + 1
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetquery_value_definition
    query_value_definition {
      autoscale   = true
      custom_unit = "USD"
      precision   = 0
      title       = "Maximum Optimisation (Monthly)"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        aggregator = "last"
        q          = "((sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service}*avg:awscostusagereport.ec2.pricing.current{$instance-type})-(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service}*avg:awscostusagereport.ec2.pricing.offers{$offer-instance-type,$offer_region,$offer_operating_system,$offer_pricing_model,$offer_lease_contract}))*720"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_m
      x               = 96
      y               = local.widget_height_s + 1
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgettoplist_definition
    toplist_definition {
      title       = "Cost ($) by Instance Type (hourly)"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        q = "top(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}*avg:awscostusagereport.ec2.pricing.current{$instance-type} by {instance-type},10,'mean','desc')"

        conditional_formats {
          comparator = ">"
          hide_value = false
          palette    = "white_on_red"
          value      = 0
        }
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 48
      y               = local.widget_height_l + 1
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgettoplist_definition
    toplist_definition {
      title       = "Potential Optimisation ($) by Instance Type (hourly)"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        q = "top((sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}*avg:awscostusagereport.ec2.pricing.current{$instance-type} by {instance-type})-(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}*avg:awscostusagereport.ec2.pricing.offers{$offer-instance-type,$offer_region,$offer_operating_system,$offer_pricing_model,$offer_lease_contract}),50,'mean','desc')"

        conditional_formats {
          comparator = ">"
          hide_value = false
          palette    = "white_on_green"
          value      = 0
        }
        conditional_formats {
          comparator = "<"
          hide_value = false
          palette    = "white_on_red"
          value      = 0
        }
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 96
      y               = local.widget_height_l + 1
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = [
        "avg",
        "max",
        "min",
        "sum",
        "value",
      ]

      legend_layout = "vertical"
      legend_size   = "0"
      show_legend   = false
      title         = "Least Utilised Instances (CPU)"
      title_align   = "left"
      title_size    = "16"

      marker {
        display_type = "ok solid"
        value        = "60 < y < 100"
      }

      marker {
        display_type = "warning solid"
        value        = "40 < y < 60"
      }

      marker {
        display_type = "error solid"
        value        = "0 < y < 40"
      }

      request {
        display_type   = "line"
        on_right_yaxis = false
        q              = "top(max:aws.ec2.cpuutilization.maximum{cloud_provider:aws,$instance-type,$team,$app,$service} by {host,instance-type}, 200, 'max', 'asc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }

      yaxis {
        include_zero = false
        scale        = "log"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 0
      y               = 40
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = [
        "avg",
        "max",
        "min",
        "sum",
        "value",
      ]

      legend_layout = "vertical"
      legend_size   = "0"
      show_legend   = false
      title         = "Potential Optimisation (hourly)"
      title_align   = "left"
      title_size    = "16"

      request {
        display_type   = "area"
        on_right_yaxis = false
        q              = "(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}*avg:awscostusagereport.ec2.pricing.current{$instance-type} by {instance-type})-(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}*avg:awscostusagereport.ec2.pricing.offers{$offer-instance-type,$offer_region,$offer_operating_system,$offer_pricing_model,$offer_lease_contract})"

        metadata {
          alias_name = "optimisation"
          expression = "(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}*avg:awscostusagereport.ec2.pricing.current{$instance-type} by {instance-type})-(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {instance-type}*avg:awscostusagereport.ec2.pricing.offers{$offer-instance-type,$offer_region,$offer_operating_system,$offer_pricing_model,$offer_lease_contract})"
        }

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "cool"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 96
      y               = 40
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = [
        "avg",
        "max",
        "min",
        "sum",
        "value",
      ]

      legend_layout = "vertical"
      legend_size   = "0"
      show_legend   = false
      title         = "Running Instances by Team"
      title_align   = "left"
      title_size    = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {team}.rollup(max, 3600), 50, 'max', 'desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 0
      y               = 56
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = []
      legend_size    = "0"
      show_legend    = false
      title          = "Under-utilised Instances by Team"
      title_align    = "left"
      title_size     = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top(sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {team}.rollup(max, 3600), 25, 'max', 'desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "warm"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 48
      y               = 56
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = []
      legend_size    = "0"
      show_legend    = false
      title          = "Potential Hourly Optimisation by Team"
      title_align    = "left"
      title_size     = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top((sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {team}.rollup(max, 3600)*avg:awscostusagereport.ec2.pricing.current{$instance-type})-(sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {team}.rollup(max, 3600)*avg:awscostusagereport.ec2.pricing.offers{$offer-instance-type,$offer_region,$offer_operating_system,$offer_pricing_model,$offer_lease_contract}),50,'mean','desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "cool"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 96
      y               = 56
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = [
        "avg",
        "max",
        "min",
        "sum",
        "value",
      ]

      legend_layout = "vertical"
      legend_size   = "0"
      show_legend   = false
      title         = "Running Instances by Service"
      title_align   = "left"
      title_size    = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {service}.rollup(max, 3600), 50, 'max', 'desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 0
      y               = 72
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = [
        "avg",
        "max",
        "min",
        "sum",
        "value",
      ]

      legend_layout = "vertical"
      legend_size   = "0"
      show_legend   = false
      title         = "Running Instances by App"
      title_align   = "left"
      title_size    = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top(sum:aws.ec2.host_ok{cloud_provider:aws,$instance-type,$team,$app,$service} by {app}.rollup(max, 3600), 50, 'max', 'desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 0
      y               = 88
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = []
      legend_size    = "0"
      show_legend    = false
      title          = "Under-utilised Instances by Service"
      title_align    = "left"
      title_size     = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top(sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {service}.rollup(max, 3600), 25, 'max', 'desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "warm"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 48
      y               = 72
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = []
      legend_size    = "0"
      show_legend    = false
      title          = "Under-utilised Instances by App"
      title_align    = "left"
      title_size     = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top(sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {app}.rollup(max, 3600), 25, 'max', 'desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "warm"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 48
      y               = 88
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = []
      legend_size    = "0"
      show_legend    = false
      title          = "Potential Hourly Optimisation by Service"
      title_align    = "left"
      title_size     = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top((sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {service}.rollup(max, 3600)*avg:awscostusagereport.ec2.pricing.current{$instance-type})-(sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {service}.rollup(max, 3600)*avg:awscostusagereport.ec2.pricing.offers{$offer-instance-type,$offer_region,$offer_operating_system,$offer_pricing_model,$offer_lease_contract}),50,'mean','desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "cool"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 96
      y               = 72
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgettimeseries_definition
    timeseries_definition {
      legend_columns = []
      legend_size    = "0"
      show_legend    = false
      title          = "Potential Hourly Optimisation by App"
      title_align    = "left"
      title_size     = "16"

      request {
        display_type   = "bars"
        on_right_yaxis = false
        q              = "top((sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {app}.rollup(max, 3600)*avg:awscostusagereport.ec2.pricing.current{$instance-type})-(sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service} by {app}.rollup(max, 3600)*avg:awscostusagereport.ec2.pricing.offers{$offer-instance-type,$offer_region,$offer_operating_system,$offer_pricing_model,$offer_lease_contract}),50,'mean','desc')"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "cool"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 96
      y               = 88
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetquery_value_definition
    query_value_definition {
      autoscale   = false
      precision   = 0
      title       = "Under-utilised Instances"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        aggregator = "avg"
        q          = "sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service}"

        conditional_formats {
          comparator = ">"
          hide_value = false
          palette    = "red_on_white"
          value      = 0
        }
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_m
      x               = 24
      y               = 8
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetquery_value_definition
    query_value_definition {
      autoscale   = true
      custom_unit = "USD"
      precision   = 0
      title       = "Under-utilised Compute Spend (Monthly)"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        aggregator = "last"
        q          = "sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service}*avg:awscostusagereport.ec2.pricing.current{$instance-type}*720"

        conditional_formats {
          comparator = ">"
          hide_value = false
          palette    = "red_on_white"
          value      = 0
        }
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_m
      x               = 72
      y               = 8
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetquery_value_definition
    query_value_definition {
      autoscale   = true
      custom_unit = "USD"
      precision   = 0
      title       = "Potential Optimisation (Monthly)"
      title_align = local.widget_title_align
      title_size  = local.widget_title_size

      request {
        aggregator = "last"
        q          = "((sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service}*avg:awscostusagereport.ec2.pricing.current{$instance-type})-(sum:myorg.underutilized.combined.hosts.count{$instance-type,$team,$app,$service}*avg:awscostusagereport.ec2.pricing.offers{$offer-instance-type,$offer_region,$offer_operating_system,$offer_pricing_model,$offer_lease_contract}))*720"

        conditional_formats {
          comparator = ">"
          hide_value = false
          palette    = "green_on_white"
          value      = 0
        }
      }
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_m
      x               = 120
      y               = 8
    }
  }

  widget {
    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetnote_definition
    note_definition {
      background_color = "white"
      content          = <<-EOT
        Accelerated Compute instances (`P2`, `P3`, `G2`, `G3`, `G4`, `F1`, `Inf1`) are not included in underutilization metrics.

        GPU instances (`P2`, `P3`, `G2`, `G3`, `G4`) require additional plugins via [AWS CloudWatch](https://aws.amazon.com/blogs/machine-learning/monitoring-gpu-utilization-with-amazon-cloudwatch/) or [Datadog NVML](https://github.com/ngi644/datadog_nvml).

        Pricing metrics do _not_ account for CPU Credits as applied to burstable (`t2`, `t3`, `t3a`) instances.
      EOT

      font_size   = "14"
      has_padding = false
      show_tick   = false
      text_align  = "left"
      tick_edge   = "left"
      tick_pos    = "50%"
    }

    # see https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/dashboard#nested-schema-for-widgetgroup_definitionwidgetwidget_layout
    widget_layout {
      height          = local.widget_height_m
      is_column_break = false
      width           = local.widget_width_l
      x               = 144
      y               = local.widget_height_s + 1
    }
  }
}
