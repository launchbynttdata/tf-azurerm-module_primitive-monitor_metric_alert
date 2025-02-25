#action group variables
action_group_name = "example-action-group"
short_name        = "exAG"
tags = {
  "environment" = "dev"
}
arm_role_receivers = [{
  name                    = "example-arm-role"
  role_id                 = "b24988ac-6180-42a0-ab88-20f7382dd24c"
  use_common_alert_schema = true
}]
email_receivers = [{
  name                    = "example-email"
  email_address           = "example@test.com"
  use_common_alert_schema = true
}]

#metric alert variables
name               = "example-metric-alert"
description        = "An example metric alert"
frequency          = "PT5M"
severity           = 2
enabled            = true
webhook_properties = { example1 = "example", example2 = "example" }

criteria = [{
  metric_namespace       = "Microsoft.Network/publicIPAddresses"
  metric_name            = "PacketsInDDoS"
  aggregation            = "Average"
  operator               = "GreaterThan"
  threshold              = 10
  skip_metric_validation = true

}]

dynamic_criteria = null
