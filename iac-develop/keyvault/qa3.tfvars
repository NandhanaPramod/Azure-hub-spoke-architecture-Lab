basename = "iskan"

backwards_compatible  = false
create_resource_group = false

keyvault_sku                   = "standard"
soft_delete_retention_days     = 7
virtual_network_name           = "iskan_qa3_vnet"
subnet_names                   = ["iskan_qa3_web", "iskan_qa3_api", "iskan_qa3_application"]
virtual_network_resource_group = "iskan_qa3"
private_link_subnet_name       = "iskan_qa3_azureapps"
action_group                   = "iskan-qa3-infra-alerts"