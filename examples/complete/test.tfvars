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
name                = "example-metric-alert"
resource_group_name = module.resource_group.name
#scopes              = ["/subscriptions/8fad0848-88a3-4620-bee0-1e65e1206c73/resourceGroups/hygtmp-apim-northeurope-dev-001-rg-001/providers/Microsoft.Network/publicIPAddresses/hygtmp-apim-northeurope-dev-001-pip-001"]
description        = "An example metric alert"
frequency          = "PT5M"
severity           = 2
enabled            = true
webhook_properties = { key1 = "value1", key2 = "value2" }

metric_namespace = "micosoft.network/publicipaddresses"
metric_name      = "PacketCount"
aggregation      = "Average"
operator         = "GreaterThan"
threshold        = 80

dimensions = [{

  name     = "Location"
  operator = "Include"
  values   = ["0.0.0.0"]

}]
