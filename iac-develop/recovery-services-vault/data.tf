data "azurerm_resource_group" "this" {
  name = "${var.basename}_${var.environment}"
}

data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.monitor_resource_group_name
}

data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_recovery_services_vault.vault.id
}