locals {
  resource_group_name = module.resource_names["resource_group"].standard
  #public_ip_name      = module.resource_names["public_ip"].minimal_random_suffix #module.resource_names["public_ip"].standard

}
