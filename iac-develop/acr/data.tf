data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.monitor_resource_group_name
}

data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_container_registry.this.id
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.virtual_network_resource_group
}

data "azurerm_private_dns_zone" "this" {
  name                = var.private_dns_zone
  resource_group_name = var.private_dns_zone_rg
}