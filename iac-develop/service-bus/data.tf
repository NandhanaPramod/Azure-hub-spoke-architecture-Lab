data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_subnet" "this" {
  name                 = "${data.azurerm_resource_group.this.name}_application"
  virtual_network_name = "${data.azurerm_resource_group.this.name}_vnet"
  resource_group_name  = data.azurerm_resource_group.this.name
}

data "azurerm_kubernetes_cluster" "this" {
  name                = "${var.basename}-${terraform.workspace}-aks"
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_client_config" "this" {}

data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.monitor_resource_group_name
}

data "azurerm_monitor_diagnostic_categories" "this" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  resource_id = each.value
}

data "azurerm_private_dns_zone" "this" {
  provider            = azurerm.dns_zone
  name                = var.private_dns_zone
  resource_group_name = var.private_dns_zone_rg
}

data "azurerm_monitor_action_group" "this" {
  resource_group_name = data.azurerm_resource_group.this.name
  name                = var.action_group
}
