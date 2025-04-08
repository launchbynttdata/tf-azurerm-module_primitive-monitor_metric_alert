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

output "metric_alert_id" {
  value       = azurerm_monitor_metric_alert.monitor_metric_alert.id
  description = "The ID of the Metric Alert."
}

output "name" {
  description = "The name of the metric alert"
  value       = azurerm_monitor_metric_alert.monitor_metric_alert.name
}
