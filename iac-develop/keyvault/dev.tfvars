backwards_compatible  = true
create_resource_group = true

enable_rbac_authorization = false

keyvault_sku                   = "standard"
soft_delete_retention_days     = 7
virtual_network_name           = "oss_dev_vnet"
subnet_names                   = ["api", "application", "web"]
virtual_network_resource_group = "oss_dev"
private_link_subnet_name       = "azureapps"
action_group                   = "oss-dev-infra-alerts"