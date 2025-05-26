basename = "iskan"

backwards_compatible  = false
create_resource_group = false

keyvault_sku                   = "standard"
soft_delete_retention_days     = 7
virtual_network_name           = "iskan_prod_vnet"
subnet_names                   = ["iskan_prod_web", "iskan_prod_api", "iskan_prod_application"]
virtual_network_resource_group = "iskan_prod"
private_link_subnet_name       = "iskan_prod_azureapps"
action_group                   = "iskan-prod-infra-alerts"