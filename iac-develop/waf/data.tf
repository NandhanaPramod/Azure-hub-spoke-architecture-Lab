data "azurerm_resource_group" "this" {
  name = "${var.basename}_${var.environment}"
}