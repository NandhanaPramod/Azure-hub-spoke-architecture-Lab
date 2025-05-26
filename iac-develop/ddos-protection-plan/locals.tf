locals {
  tags = merge(
    var.default_tags,
    {
      Environment  = upper(var.environment)
      Location     = lower(data.azurerm_resource_group.this.location)
      ServiceClass = "prod"
    }
  )
}