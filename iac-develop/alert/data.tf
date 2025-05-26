data "azurerm_subscription" "current" {}

data "azurerm_monitor_action_group" "this" {
  resource_group_name = local.resource_group_name
  name                = var.action_group
}
