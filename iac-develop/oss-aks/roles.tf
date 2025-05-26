resource "azurerm_role_assignment" "aks_to_static_content_role" {
  scope                = data.azurerm_storage_account.this["static"].id
  role_definition_name = "Contributor"
  principal_id         = module.aks.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_to_persistent_role" {
  count                = var.persistent_sa_role_required ? 1 : 0
  scope                = data.azurerm_storage_account.this["persistent"].id
  role_definition_name = "Contributor"
  principal_id         = module.aks.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_to_acr_role" {
  scope                = data.azurerm_container_registry.this.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity[0].object_id

  provider = azurerm.hub
}

resource "azurerm_role_assignment" "aks_to_vmms_role" {
  principal_id         = module.aks.kubelet_identity[0].object_id
  scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}/resourceGroups/${module.aks.node_resource_group}"
  role_definition_name = "Virtual Machine Contributor"
}

resource "azurerm_role_assignment" "identity_to_kv" {
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  scope                = data.azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
}

resource "azurerm_role_assignment" "aks_to_identity_role" {
  principal_id         = module.aks.kubelet_identity[0].object_id
  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Managed Identity Operator"
}

resource "azurerm_role_assignment" "identity_to_nodes" {
  scope                = data.azurerm_resource_group.this.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_user_assigned_identity.this.client_id

  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "aks_to_subnet_role" {
  principal_id         = module.aks.cluster_identity.principal_id
  scope                = data.azurerm_virtual_network.this.id
  role_definition_name = "Network Contributor"
}

# ## Might be needed for qa
resource "azurerm_role_assignment" "aks_to_keyvault_role" {
  principal_id         = module.aks.kubelet_identity[0].object_id
  scope                = data.azurerm_key_vault.this.id
  role_definition_name = "Managed Identity Operator"

  lifecycle {
    ignore_changes = [scope]
  }
}
