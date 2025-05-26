data "azurerm_virtual_network" "hub" {
  name                = var.hub_vnet_name
  resource_group_name = var.hub_resource_group
}

data "azurerm_virtual_network" "spoke" {
  name                = var.spoke_vnet_name
  resource_group_name = var.spoke_resource_group

  provider = azurerm.site_spoke
}

data "azurerm_client_config" "this" { }
  
data "azurerm_client_config" "spoke" { 
  provider = azurerm.site_spoke 
}

resource "azurerm_role_assignment" "this" {
  scope                            = data.azurerm_virtual_network.spoke.id
  role_definition_name             = "Network Contributor"
  principal_id                     = data.azurerm_client_config.this.object_id

  provider = azurerm.site_spoke
}

resource "azurerm_role_assignment" "spoke_sp_to_hub" {
  scope                            = data.azurerm_virtual_network.hub.id
  role_definition_name             = "Network contributor"
  principal_id                     = data.azurerm_client_config.spoke.object_id
}

resource "azurerm_virtual_network_peering" "this1" {
  depends_on = [azurerm_role_assignment.this]
  name                         = "${var.basename}_${var.hub_peer_name}_peer"
  resource_group_name          = data.azurerm_virtual_network.hub.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.hub.name
  remote_virtual_network_id    = data.azurerm_virtual_network.spoke.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
}

resource "azurerm_virtual_network_peering" "this2" {
  depends_on = [azurerm_role_assignment.spoke_sp_to_hub]
  name                         = "${var.basename}_${var.spoke_peer_name}_peer"
  resource_group_name          = data.azurerm_virtual_network.spoke.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  # ## Ensure `Use the remote virtual network's gateway or Route Server = true` for spoke to hub peer
  # allow_gateway_transit        = var.allow_gateway_transit
  allow_gateway_transit        = false
  use_remote_gateways          = true

  provider = azurerm.site_spoke
}
