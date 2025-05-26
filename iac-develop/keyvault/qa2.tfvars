basename = "iskan"

backwards_compatible  = false
create_resource_group = false

keyvault_sku                   = "standard"
soft_delete_retention_days     = 7
virtual_network_name           = "iskan_qa2_vnet"
subnet_names                   = ["iskan_qa2_web", "iskan_qa2_api", "iskan_qa2_application"]
virtual_network_resource_group = "iskan_qa2"
private_link_subnet_name       = "iskan_qa2_azureapps"
action_group                   = "iskan-qa2-infra-alerts"