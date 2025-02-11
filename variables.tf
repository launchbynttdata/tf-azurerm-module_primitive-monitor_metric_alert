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

variable "metric_namespace" {
  type        = string
  description = "The namespace of the metric."
}

variable "metric_name" {
  type        = string
  description = "The name of the metric."
}

variable "aggregation" {
  type        = string
  description = "The aggregation type of the metric(e.g., 'Average', 'Total')."
}

variable "operator" {
  type        = string
  description = "The comparison operator (e.g., 'GreaterThan')."
}

variable "threshold" {
  type        = number
  description = "The threshold value."
}

variable "dimensions" {
  type = list(object({
    name     = string
    operator = string
    values   = list(string)
  }))
  description = "The list of metric dimensions."
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
