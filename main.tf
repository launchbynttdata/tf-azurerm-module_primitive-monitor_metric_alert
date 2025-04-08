// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "azurerm_monitor_metric_alert" "monitor_metric_alert" {

  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  severity            = var.severity
  enabled             = var.enabled
  description         = var.description
  frequency           = var.frequency
  window_size         = var.window_size
  auto_mitigate       = var.auto_mitigate

  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id    = action.value
      webhook_properties = var.webhook_properties
    }
  }

  dynamic "criteria" {
    for_each = var.criteria
    content {
      metric_namespace       = criteria.value.metric_namespace
      metric_name            = criteria.value.metric_name
      aggregation            = criteria.value.aggregation
      operator               = criteria.value.operator
      threshold              = criteria.value.threshold
      skip_metric_validation = lookup(criteria.value, "skip_metric_validation", false)

      dynamic "dimension" {
        for_each = lookup(criteria.value, "dimensions", [])
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  dynamic "dynamic_criteria" {
    for_each = var.dynamic_criteria != null ? { "enabled" = var.dynamic_criteria } : {}
    content {
      metric_namespace       = dynamic_criteria.value.metric_namespace
      metric_name            = dynamic_criteria.value.metric_name
      aggregation            = dynamic_criteria.value.aggregation
      operator               = dynamic_criteria.value.operator
      alert_sensitivity      = dynamic_criteria.value.alert_sensitivity
      ignore_data_before     = dynamic_criteria.value.ignore_data_before
      skip_metric_validation = lookup(dynamic_criteria.value, "skip_metric_validation", false)

      dynamic "dimension" {
        for_each = lookup(dynamic_criteria.value, "dimensions", [])
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }
  tags = var.tags

}
