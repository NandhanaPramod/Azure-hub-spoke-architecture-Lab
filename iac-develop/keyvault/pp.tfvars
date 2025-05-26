basename = "iskan"

backwards_compatible  = false
create_resource_group = false

keyvault_sku                   = "standard"
soft_delete_retention_days     = 7
virtual_network_name           = "iskan_pp_vnet"
subnet_names                   = ["iskan_pp_web", "iskan_pp_api", "iskan_pp_application"]
virtual_network_resource_group = "iskan_pp"
private_link_subnet_name       = "iskan_pp_azureapps"
action_group                   = "iskan-pp-infra-alerts"