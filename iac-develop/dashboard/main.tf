resource "azurerm_portal_dashboard" "hub_dashboard" {
  for_each            = terraform.workspace == "hub" ? { for dashboard in var.hub_dashboards : dashboard.name => dashboard } : {}
  name                = each.value.name
  resource_group_name = local.resource_group_name
  location            = var.location
  dashboard_properties = templatefile("${path.cwd}/dashboards/${each.value.dashboard_config_file}", {
    application_gateway_name        = each.value.application_gateway_name
    application_gateway_resource_id = data.azurerm_application_gateway.this[each.value.name].id
  })

  tags = merge(
    local.tags,
    {
      ServiceClass = each.value.service_class
    }
  )
}

resource "azurerm_portal_dashboard" "spoke_dashboard" {
  for_each            = terraform.workspace == "hub" ? {} : { for dashboard in var.spoke_dashboards : dashboard.name => dashboard }
  name                = each.value.name
  resource_group_name = local.resource_group_name
  location            = var.location
  dashboard_properties = templatefile("${path.cwd}/dashboards/${each.value.dashboard_config_file}", {
    aks_name        = each.value.aks_name
    aks_namespace   = each.value.aks_namespace
    aks_resource_id = data.azurerm_kubernetes_cluster.this[each.value.name].id
    aks_namespace   = each.value.aks_namespace
  })

  tags = merge(
    local.tags,
    {
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )
}