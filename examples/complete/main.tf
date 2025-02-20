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

# This module generates the resource-name of resources based on resource_type, naming_prefix, env etc.
module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 2.0"

  for_each = var.resource_names_map

  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  region                  = join("", split("-", var.region))
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  maximum_length          = each.value.max_length
  instance_resource       = var.instance_resource
}

module "resource_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm"
  version = "~> 1.0"

  name     = local.resource_group_name
  location = var.region
  tags = {
    resource_name = local.resource_group_name
  }
}

module "public_ip" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/public_ip/azurerm"
  version = "~> 1.0"

  name                = module.resource_names["public_ip"].minimal_random_suffix #"ip-name" #module.resource_names["public_ip"].minimal_random_suffix
  resource_group_name = module.resource_group.name
  location            = var.region
  allocation_method   = var.allocation_method

  depends_on = [module.resource_group]
}

module "monitor_action_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/monitor_action_group/azurerm"
  version = "~> 1.0.0"

  action_group_name   = var.action_group_name
  resource_group_name = module.resource_group.name
  short_name          = var.short_name
  tags                = var.tags
  arm_role_receivers  = var.arm_role_receivers
  email_receivers     = var.email_receivers
  depends_on          = [module.resource_group]
}

module "monitor_metric_alert" {
  source              = "../.."
  name                = var.name
  resource_group_name = module.resource_group.name
  scopes              = [module.public_ip.id]
  description         = var.description
  frequency           = var.frequency
  severity            = var.severity
  enabled             = var.enabled
  action_group_ids    = module.monitor_action_group.action_group_id
  webhook_properties  = var.webhook_properties

  criteria   = var.criteria
  depends_on = [module.resource_group]

}
