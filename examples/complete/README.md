# complete

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.113 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_monitor_action_group"></a> [monitor\_action\_group](#module\_monitor\_action\_group) | terraform.registry.launch.nttdata.com/module_primitive/monitor_action_group/azurerm | ~> 1.0.0 |
| <a name="module_monitor_metric_alert"></a> [monitor\_metric\_alert](#module\_monitor\_metric\_alert) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the Metric Alert. | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | The list of resources to monitor. | `list(string)` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (optional)The description of the Metric Alert. | `string` | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | (optional)The evaluation frequency in seconds. | `string` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | (optional)The severity of alert. | `number` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (optional)Whether the alert is enabled. | `bool` | n/a | yes |
| <a name="input_webhook_properties"></a> [webhook\_properties](#input\_webhook\_properties) | (optional)The webhook properties. | `map(string)` | n/a | yes |
| <a name="input_metric_namespace"></a> [metric\_namespace](#input\_metric\_namespace) | The namespace of the metric. | `string` | n/a | yes |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The name of the metric. | `string` | n/a | yes |
| <a name="input_aggregation"></a> [aggregation](#input\_aggregation) | The aggregation type of the metric(e.g., 'Average', 'Total'). | `string` | n/a | yes |
| <a name="input_operator"></a> [operator](#input\_operator) | The comparison operator (e.g., 'GreaterThan'). | `string` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The threshold value. | `number` | n/a | yes |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | The list of metric dimensions. | <pre>list(object({<br>    name     = string<br>    operator = string<br>    values   = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "resource_group": {<br>    "max_length": 90,<br>    "name": "rg"<br>  }<br>}</pre> | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"network"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) The location where the resource will be created. Must not have spaces<br>    For example, eastus, westus, centralus etc. | `string` | `"eastus2"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_action_group_name"></a> [action\_group\_name](#input\_action\_group\_name) | Specifies the Name of the action group. | `string` | n/a | yes |
| <a name="input_short_name"></a> [short\_name](#input\_short\_name) | The short name of the action group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_arm_role_receivers"></a> [arm\_role\_receivers](#input\_arm\_role\_receivers) | List of ARM role receivers. Each entry should have:<br>  - name (string): The name of the ARM role receiver.<br>  - role\_id (string): The ARM role ID.<br>  - use\_common\_alert\_schema (bool, optional): Whether to use the common alert schema. | <pre>list(object({<br>    name                    = string<br>    role_id                 = string<br>    use_common_alert_schema = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_email_receivers"></a> [email\_receivers](#input\_email\_receivers) | List of email receivers. Each entry should have:<br>  - name (string): The name of the ARM role receiver.<br>  - email\_address (string): The email address to receive alerts.<br>  - use\_common\_alert\_schema (bool, optional): Whether to use the common alert schema. | <pre>list(object({<br>    name                    = string<br>    email_address           = string<br>    use_common_alert_schema = optional(bool)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_metric_alert_id"></a> [metric\_alert\_id](#output\_metric\_alert\_id) | The ID of the created Metric Alert |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
