data "azurerm_application_gateway" "this" {
  for_each            = terraform.workspace == "hub" ? { for dashboard in var.hub_dashboards : dashboard.name => dashboard.application_gateway_name } : {}
  name                = each.value
  resource_group_name = local.resource_group_name
}

data "azurerm_kubernetes_cluster" "this" {
  for_each            = terraform.workspace == "hub" ? {} : { for dashboard in var.spoke_dashboards : dashboard.name => dashboard.aks_name }
  name                = each.value
  resource_group_name = local.resource_group_name
}