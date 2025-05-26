data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_network_ddos_protection_plan" "this" {
  name                = "${var.basename}-ddos-protection-plan"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = local.tags
}
