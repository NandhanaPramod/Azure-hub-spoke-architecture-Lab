backwards_compatible  = true
create_resource_group = true

enable_rbac_authorization = false

keyvault_sku                   = "standard"
soft_delete_retention_days     = 7
virtual_network_name           = "oss_qa_vnet"
subnet_names                   = ["oss_qa_web", "oss_qa_api", "oss_qa_application"]
virtual_network_resource_group = "oss_qa"
private_link_subnet_name       = "oss_qa_azureapps"
action_group                   = "oss-qa-infra-alerts"