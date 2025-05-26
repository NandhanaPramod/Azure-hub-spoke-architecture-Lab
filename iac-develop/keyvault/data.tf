data "azurerm_client_config" "this" {}

data "azurerm_subnet" "this" {
  for_each             = toset(var.subnet_names)
  name                 = each.value
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group
}

data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.monitor_resource_group_name
}

data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_key_vault.this.id
}

data "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 0 : 1
  name  = local.keyvault_resource_group_name
}

data "azurerm_subnet" "private_link_subnet" {
  name                 = var.private_link_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = "${var.basename}_${terraform.workspace}"
}

data "azurerm_private_dns_zone" "this" {
  provider            = azurerm.dns_zone
  name                = var.private_dns_zone
  resource_group_name = var.private_dns_zone_rg
}

data "azurerm_linux_function_app" "this" {
  provider            = azurerm.dns_zone
  name                = var.sas_rotation_function_app
  resource_group_name = var.sas_rotation_function_rg
}

data "azurerm_monitor_action_group" "this" {
  resource_group_name = var.virtual_network_resource_group
  name                = var.action_group
}

data "azurerm_log_analytics_workspace" "prod" {
  provider            = azurerm.prod
  name                = "iskan-prod-la-workspace"
  resource_group_name = "iskan_prod"
}