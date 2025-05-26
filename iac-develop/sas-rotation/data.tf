data "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  resource_group_name = local.resource_group_name
}

data "azurerm_application_insights" "this" {
  name                = var.app_insights_name
  resource_group_name = var.app_insights_rg
}

data "azurerm_resource_group" "this" {
  name = local.resource_group_name
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = local.resource_group_name
}

data "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_workspace
  resource_group_name = var.app_insights_rg
}

data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_linux_function_app.this.id
}

data "azurerm_monitor_action_group" "this" {
  resource_group_name = local.resource_group_name
  name                = var.action_group
}