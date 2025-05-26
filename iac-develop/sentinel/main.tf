# https://techcommunity.microsoft.com/t5/microsoft-defender-for-cloud/deploy-microsoft-defender-for-cloud-via-terraform/ba-p/3563710

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.basename}-sentinel-la-workspace"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = "PerGB2018"

  tags = local.tags
}

resource "azurerm_log_analytics_solution" "this" {
  # ## Solution name should exactly `SecurityInsights`. do not change it
  solution_name         = "SecurityInsights"
  location              = data.azurerm_resource_group.this.location
  resource_group_name   = data.azurerm_resource_group.this.name
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
  
  tags = local.tags
}