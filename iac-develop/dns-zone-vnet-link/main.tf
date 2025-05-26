resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  depends_on = [
    azurerm_role_assignment.this
  ]
  provider              = azurerm.dns_zone
  for_each              = var.private_zones
  name                  = "${var.vnet_name}-link"
  resource_group_name   = each.value
  private_dns_zone_name = data.azurerm_private_dns_zone.this[each.key].name
  virtual_network_id    = data.azurerm_virtual_network.this.id

  tags = local.tags
}

resource "azurerm_role_assignment" "this" {
  provider             = azurerm.dns_zone
  for_each             = var.private_zones
  scope                = data.azurerm_private_dns_zone.this[each.key].id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = data.azurerm_client_config.this.object_id
}