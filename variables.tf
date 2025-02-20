variable "name" {
  type        = string
  description = "The name of the Metric Alert."
}

variable "scopes" {
  type        = list(string)
  description = "The list of resources to monitor."
}

variable "description" {
  type        = string
  description = "(optional)The description of the Metric Alert."
}

variable "frequency" {
  type        = string
  description = "(optional)The evaluation frequency in seconds."
}

variable "severity" {
  type        = number
  description = "(optional)The severity of alert."
}

variable "enabled" {
  type        = bool
  description = "(optional)Whether the alert is enabled."
}

variable "action_group_ids" {
  type        = string
  description = "The list of Action Group IDs."
}

variable "webhook_properties" {
  type        = map(string)
  description = "(optional)The webhook properties."
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

variable "criteria" {
  description = "List of metric criteria for the alert"
  type = list(object({
    metric_namespace       = string
    metric_name            = string
    aggregation            = string
    operator               = string
    threshold              = string
    skip_metric_validation = optional(bool, false)
    dimensions = optional(list(object({
      name     = string
      operator = string
      values   = list(string)
    })), [])
  }))
}
