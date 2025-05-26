data "azurerm_monitor_action_group" "this" {
  for_each            = merge({ for group in local.action_groups : "${group.alert_name}-${group.action_group}" => group }, { "default" : { action_group = var.default_alerts_action_group } })
  resource_group_name = var.resource_group_name
  name                = each.value.action_group
}

data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.monitor_resource_group_name
}

data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = azurerm_application_gateway.this.id
}

