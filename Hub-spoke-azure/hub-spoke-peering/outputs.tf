output "hub_to_spoke_peering_id" {
  description = "The ID of the Hub to Spoke VNet Peering"
  value       = azurerm_virtual_network_peering.hub_to_spoke.id
}

output "spoke_to_hub_peering_id" {
  description = "The ID of the Spoke to Hub VNet Peering"
  value       = azurerm_virtual_network_peering.spoke_to_hub.id
}

output "hub_to_spoke_peering_name" {
  description = "The name of the Hub to Spoke VNet Peering"
  value       = azurerm_virtual_network_peering.hub_to_spoke.name
}

output "spoke_to_hub_peering_name" {
  description = "The name of the Spoke to Hub VNet Peering"
  value       = azurerm_virtual_network_peering.spoke_to_hub.name
} 