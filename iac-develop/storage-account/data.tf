data "azurerm_subnet" "this" {
  for_each             = { for subnet in local.subnets : "${subnet.name_suffix}-${subnet.subnet_name}" => subnet }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_resource_group
}

data "azurerm_private_dns_zone" "this" {
  provider            = azurerm.dns_zone
  for_each            = { for zone in local.private_dns_zone : "${zone.name_suffix}-${zone.private_dns_zone}" => zone }
  name                = each.value.private_dns_zone
  resource_group_name = each.value.private_dns_zone_rg
}

data "azurerm_linux_function_app" "this" {
  provider            = azurerm.dns_zone
  name                = var.sas_rotation_function
  resource_group_name = var.sas_rotation_function_rg
}


data "azurerm_monitor_diagnostic_categories" "this" {
  for_each    = { for sa in var.storage_accounts : sa.name_suffix => sa }
  resource_id = azurerm_storage_account.this[each.value.name_suffix].id
}

data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.monitor_resource_group_name
}

data "azurerm_monitor_action_group" "this" {
  resource_group_name = local.resource_group_name
  name                = var.action_group
}

data "azurerm_monitor_diagnostic_categories" "blob" {
  for_each    = { for sa in var.storage_accounts : sa.name_suffix => sa }
  resource_id = "${azurerm_storage_account.this[each.value.name_suffix].id}/blobServices/default/"
}

data "azurerm_monitor_diagnostic_categories" "queue" {
  for_each    = { for sa in var.storage_accounts : sa.name_suffix => sa }
  resource_id = "${azurerm_storage_account.this[each.value.name_suffix].id}/queueServices/default/"
}

data "azurerm_monitor_diagnostic_categories" "table" {
  for_each    = { for sa in var.storage_accounts : sa.name_suffix => sa }
  resource_id = "${azurerm_storage_account.this[each.value.name_suffix].id}/tableServices/default/"
}

data "azurerm_monitor_diagnostic_categories" "file" {
  for_each    = { for sa in var.storage_accounts : sa.name_suffix => sa }
  resource_id = "${azurerm_storage_account.this[each.value.name_suffix].id}/fileServices/default/"
}

data "azurerm_log_analytics_workspace" "prod" {
  provider            = azurerm.prod
  name                = "iskan-prod-la-workspace"
  resource_group_name = "iskan_prod"
}

