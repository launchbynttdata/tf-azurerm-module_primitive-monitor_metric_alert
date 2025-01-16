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

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
  }))

  default = {
    resource_group = {
      name       = "rg"
      max_length = 80
    }
  }
}

variable "region" {
  type        = string
  description = <<EOF
    (Required) The location where the resource will be created. Must not have spaces
    For example, eastus, westus, centralus etc.
  EOF
  nullable    = false
  default     = "eastus2"

  validation {
    condition     = length(regexall("\\b \\b", var.region)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "database"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false
  default     = "dev"

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "location" {
  description = "Location of the Postgres Flexible Server"
  type        = string
  default     = "eastus"
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "metric_alerts" {
  type = map(object({
    description   = string
    action_groups = optional(set(string))

    criterias = optional(map(object({
      threshold        = number
      metric_namespace = string
      metric_name      = string
      aggregation      = string
      operator         = string
      dimensions = map(object({
        operator = string
        values   = list(string)
      }))
    })))

    dynamic_criteria = optional(object({
      alert_sensitivity = string
      metric_name       = string
      metric_namespace  = string
      aggregation       = string
      operator          = string
      dimensions = map(object({
        operator = string
        values   = list(string)
      }))
    }))
  }))
  default = {}

  validation {
    condition = alltrue(
      [for alert in var.metric_alerts : !(alert.criterias == null && alert.dynamic_criteria == null)],
    )
    error_message = "At least one of 'criteria', 'dynamic_criteria' must be defined for all metric alerts"
  }
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

# variable "action_groups" {
#   type = map(object({
#     arm_role_receivers = optional(set(string))
#     email_receivers    = optional(set(string))
#   }))
#   default = {}
# }
