# tf-azurerm-module_primitive-monitor_metric_alert

## Overview

This module creates Azure Monitor metric alerts with static or dynamic criteria, optional action groups, and configurable severity, evaluation frequency, and window size.

## Usage

```hcl
module "monitor_metric_alert" {
	source = "terraform.registry.launch.nttdata.com/module_primitive/monitor_metric_alert/azurerm"

	name                = "example-metric-alert"
	resource_group_name = "example-rg"
	scopes              = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Compute/virtualMachines/example-vm"]
	description         = "CPU utilization is high"

	criteria = [
		{
			metric_namespace = "Microsoft.Compute/virtualMachines"
			metric_name      = "Percentage CPU"
			aggregation      = "Average"
			operator         = "GreaterThan"
			threshold        = 80
		}
	]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.77, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_metric_alert.monitor_metric_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_group_ids"></a> [action\_group\_ids](#input\_action\_group\_ids) | (Optional) The list of Action Group IDs. | `list(string)` | `[]` | no |
| <a name="input_auto_mitigate"></a> [auto\_mitigate](#input\_auto\_mitigate) | (Optional) Whether to automatically mitigate the alert. Defaults to true. | `bool` | `true` | no |
| <a name="input_criteria"></a> [criteria](#input\_criteria) | (Optional) List of metric criteria for the alert | <pre>list(object({<br/>    metric_namespace       = string<br/>    metric_name            = string<br/>    aggregation            = string<br/>    operator               = string<br/>    threshold              = number<br/>    skip_metric_validation = optional(bool, false)<br/>    dimensions = optional(list(object({<br/>      name     = string<br/>      operator = string<br/>      values   = list(string)<br/>    })), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the Metric Alert. | `string` | n/a | yes |
| <a name="input_dynamic_criteria"></a> [dynamic\_criteria](#input\_dynamic\_criteria) | (Optional) A single metric dynamic criteria for the alert | <pre>object({<br/>    metric_namespace       = string<br/>    metric_name            = string<br/>    aggregation            = string<br/>    operator               = string<br/>    alert_sensitivity      = string<br/>    ignore_data_before     = optional(string)<br/>    skip_metric_validation = optional(bool, false)<br/>    dimensions = optional(list(object({<br/>      name     = string<br/>      operator = string<br/>      values   = list(string)<br/>    })), [])<br/>  })</pre> | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether the alert is enabled. | `bool` | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | (Optional) The evaluation frequency. Allowed values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M. | `string` | `"PT1M"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Metric Alert. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group. | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | (Required) The list of resources to monitor. | `list(string)` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | (Optional) The severity of alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3. | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_webhook_properties"></a> [webhook\_properties](#input\_webhook\_properties) | (Optional) The webhook properties. | `map(string)` | n/a | yes |
| <a name="input_window_size"></a> [window\_size](#input\_window\_size) | (Optional) The window size. Allowed values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Defaults to PT5M. | `string` | `"PT5M"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_metric_alert_id"></a> [metric\_alert\_id](#output\_metric\_alert\_id) | The ID of the Metric Alert. |
| <a name="output_name"></a> [name](#output\_name) | The name of the metric alert |
<!-- END_TF_DOCS -->

## Module Development

Use this repository as a standard Launch Terraform primitive module.

- Keep examples and tests aligned with code changes because they are part of the public contract.
- Preserve generated files and automation patterns from the shared skeleton unless a module-specific exception is required.
- Prefer make targets and pre-commit hooks over ad hoc commands to match CI behavior.

## Pre-Requisites

The following commands should be available on your system:

- asdf or mise
- make
- python3 (for pre-commit)

Install pinned tool versions and bootstrap dependencies from the repository root:

```sh
make configure
```

## Pre-Commit Hooks

This repository uses [.pre-commit-config.yaml](.pre-commit-config.yaml) to run Terraform, Go, and repository hygiene checks.

Install local hooks:

```sh
pre-commit install --hook-type commit-msg
```

Run all hooks manually:

```sh
pre-commit run --all-files
```

## Local Validation

Run the same validations used in CI:

```sh
make lint
make check
```

If a hook or generated file changes content (for example terraform-docs), commit the updates and rerun the checks.

## Review And Merge Process

- Open a pull request with a clear summary of functional and test-impacting changes.
- Resolve all review comments and ensure CI is green before merge.
- Keep commits focused and use conventional commit messages when possible.

## Automatic Updates

This repository receives periodic updates from the shared launch-terraform-skeleton baseline via Copier automation. Keep skeleton-managed files aligned with upstream expectations so automated updates continue to merge cleanly.
