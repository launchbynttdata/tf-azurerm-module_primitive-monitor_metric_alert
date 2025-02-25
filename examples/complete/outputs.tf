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
  value       = module.monitor_metric_alert.metric_alert_id
  description = "The ID of the created Metric Alert"
}

output "resource_group_name" {
  description = "Resource group name of the managed action group instance"
  value       = module.resource_group.name
}

output "monitor_metric_alert_name" {
  description = "The name of the alert"
  value       = module.monitor_metric_alert.name
}

output "action_group_id" {
  description = "The ID of the created action group."
  value       = module.monitor_action_group.action_group_id
}
