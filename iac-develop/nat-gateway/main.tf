resource "azurerm_public_ip" "this" {
  name                = local.ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = var.zones
}

resource "azurerm_nat_gateway" "this" {
  name                = local.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.nat_gateway_sku
  zones               = var.zones
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this.id
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  subnet_id      = data.azurerm_subnet.this.id
  nat_gateway_id = azurerm_nat_gateway.this.id
}