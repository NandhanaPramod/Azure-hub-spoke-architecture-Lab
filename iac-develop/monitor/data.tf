data "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 0 : 1
  name  = local.monitor_resource_group_name
}