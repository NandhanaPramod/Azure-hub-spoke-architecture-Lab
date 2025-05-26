data "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = local.resource_group_name
}

data "azurerm_private_dns_zone" "this" {
  provider            = azurerm.dns_zone
  for_each            = var.private_zones
  name                = each.key
  resource_group_name = each.value
}

data "azurerm_client_config" "this" {}