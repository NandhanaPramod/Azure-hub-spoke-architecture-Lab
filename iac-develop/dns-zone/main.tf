resource "azurerm_private_dns_zone" "this" {
  for_each            = toset(var.private_zones)
  name                = each.value
  resource_group_name = local.resource_group_name

  tags = local.tags
}