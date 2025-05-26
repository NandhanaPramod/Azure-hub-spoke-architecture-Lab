data "azurerm_resource_group" "this" {
  name = local.basename
}

data "azurerm_subnet" "this" {
  name                 = local.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.this.name
}

data "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.monitor_resource_group_name
}