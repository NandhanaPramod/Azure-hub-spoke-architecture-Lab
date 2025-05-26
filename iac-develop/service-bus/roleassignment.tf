# Assign AKS Cluster to the Service Bus (App)
resource "azurerm_role_assignment" "roleassignment_aks_sender" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  scope                = each.value
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = data.azurerm_kubernetes_cluster.this.identity[0].principal_id
}

resource "azurerm_role_assignment" "roleassignment_aks_receiver" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  scope                = each.value
  role_definition_name = "Azure Service Bus Data Receiver"
  principal_id         = data.azurerm_kubernetes_cluster.this.identity[0].principal_id
}

# Assign AKS Cluster Nodepool to the Service Bus (Managed Identity)
resource "azurerm_role_assignment" "roleassignment_aks_nodepool_sender" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  scope                = each.value
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = data.azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "roleassignment_aks_nodepool_receiver" {
  for_each = {
    for namespace in module.servicebus.namespaces : namespace.name => namespace.id
  }
  scope                = each.value
  role_definition_name = "Azure Service Bus Data Receiver"
  principal_id         = data.azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}
