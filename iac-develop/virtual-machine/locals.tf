
locals {
  basename      = join("_", [var.basename, var.environment])
  keyvault_name = "${var.basename}-${terraform.workspace}-keyvault"
  keyvault_resource_group_name = var.backwards_compatible ? "${var.basename}-${terraform.workspace}-keyvault-rg" : join("_", [var.basename, terraform.workspace])
  tags = merge(
    var.default_tags,
    {
      Environment  = upper(var.environment)
      Location     = lower(data.azurerm_resource_group.this.location)
      ServiceClass = "prod"
    }
  )
}
