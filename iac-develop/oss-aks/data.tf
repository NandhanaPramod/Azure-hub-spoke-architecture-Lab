data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.monitor_resource_group_name
}

data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = module.aks.aks_id
}

data "azurerm_monitor_action_group" "this" {
  resource_group_name = var.resource_group_name
  name                = var.action_group
}

data "azurerm_monitor_action_group" "app" {
  count               = var.app_action_group != null ? 1 : 0
  resource_group_name = var.resource_group_name
  name                = var.app_action_group
}
