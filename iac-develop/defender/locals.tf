locals {
  tags = merge(
    var.default_tags,
    {
      Environment  = upper(terraform.workspace)
      Location     = lower(data.azurerm_resource_group.this.location)
      ServiceClass = "prod"
    }
  )
}
  