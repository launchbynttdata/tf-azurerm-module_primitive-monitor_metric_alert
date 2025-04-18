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
//

variable "name" {
  type        = string
  description = "(Required) The name of the Metric Alert."
}

variable "scopes" {
  type        = list(string)
  description = "(Required) The list of resources to monitor."
}

variable "description" {
  type        = string
  description = "(Optional) The description of the Metric Alert."
}

variable "frequency" {
  type        = string
  description = "(Optional) The evaluation frequency. Allowed values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M."
  validation {
    condition     = contains(["PT1M", "PT5M", "PT15M", "PT30M", "PT1H"], var.frequency)
    error_message = "Frequency must be one of: PT1M, PT5M, PT15M, PT30M, PT1H."
  }
  default = "PT1M"
}

variable "severity" {
  type        = number
  description = "(Optional) The severity of alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3."
  validation {
    condition     = var.severity >= 0 && var.severity <= 4
    error_message = "Severity must be between 0 and 4."
  }
  default = 3
}

variable "enabled" {
  type        = bool
  description = "(Optional) Whether the alert is enabled."
}

variable "action_group_ids" {
  type        = list(string)
  description = "(Optional) The list of Action Group IDs."
  default     = []
}

variable "webhook_properties" {
  type        = map(string)
  description = "(Optional) The webhook properties."
}

variable "window_size" {
  type        = string
  description = "(Optional) The window size. Allowed values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Defaults to PT5M."
  validation {
    condition     = contains(["PT1M", "PT5M", "PT15M", "PT30M", "PT1H", "PT6H", "PT12H", "P1D"], var.window_size)
    error_message = "Window size must be one of: PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H, P1D."
  }
  default = "PT5M"
}

variable "auto_mitigate" {
  type        = bool
  description = "(Optional) Whether to automatically mitigate the alert. Defaults to true."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group."
}

variable "dynamic_criteria" {
  description = "(Optional) A single metric dynamic criteria for the alert"
  type = object({
    metric_namespace       = string
    metric_name            = string
    aggregation            = string
    operator               = string
    alert_sensitivity      = string
    ignore_data_before     = optional(string)
    skip_metric_validation = optional(bool, false)
    dimensions = optional(list(object({
      name     = string
      operator = string
      values   = list(string)
    })), [])
  })
}

variable "criteria" {
  description = "(Optional) List of metric criteria for the alert"
  type = list(object({
    metric_namespace       = string
    metric_name            = string
    aggregation            = string
    operator               = string
    threshold              = number
    skip_metric_validation = optional(bool, false)
    dimensions = optional(list(object({
      name     = string
      operator = string
      values   = list(string)
    })), [])
  }))
}
