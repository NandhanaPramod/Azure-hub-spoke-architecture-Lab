data "azurerm_subnet" "this" {
  name                 = local.subent_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_public_ip.this.id
}

data "azurerm_log_analytics_workspace" "this" {
  name = var.log_analytics_workspace_name
  resource_group_name = var.monitor_resource_group_name
}
