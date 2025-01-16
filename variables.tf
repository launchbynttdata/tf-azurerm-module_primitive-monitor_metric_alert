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

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}
