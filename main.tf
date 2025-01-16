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
  for_each = var.metric_alerts

  name                = each.value.name
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  description         = each.value.description

  dynamic "action" {
    for_each = each.value.action_groups != null ? each.value.action_groups : toset([])
    content {
      action_group_id = action_groups.value.action_group_id
    }
  }

  dynamic "criteria" {
    for_each = each.value.criterias != null ? each.value.criterias : {}
    content {
      metric_namespace = criteria.value.metric_namespace
      metric_name      = criteria.value.metric_name
      aggregation      = criteria.value.aggregation
      operator         = criteria.value.operator
      threshold        = criteria.value.threshold

      dynamic "dimension" {
        for_each = criteria.value.dimensions
        content {
          name     = dimension.key
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  dynamic "dynamic_criteria" {
    for_each = each.value.dynamic_criteria != null ? ["dynamic_criteria"] : []
    content {
      metric_namespace  = each.value.dynamic_criteria.metric_namespace
      metric_name       = each.value.dynamic_criteria.metric_name
      aggregation       = each.value.dynamic_criteria.aggregation
      operator          = each.value.dynamic_criteria.operator
      alert_sensitivity = each.value.dynamic_criteria.alert_sensitivity

      dynamic "dimension" {
        for_each = each.value.dynamic_criteria.dimensions
        content {
          name     = dimension.key
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  tags = var.tags

}
