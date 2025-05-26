# ## Role assignment for sp_tf_hub to read certificates from KV
resource "azurerm_role_assignment" "sp_to_vault_secret" {
  scope                = data.azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.this.object_id
}

# ## NonPROD v1 IAM
resource "azurerm_user_assigned_identity" "uai" {
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location

  name = "${local.app_gw_name}-identity"
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = data.azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
}

# ## PRODv1 IAM
resource "azurerm_user_assigned_identity" "prodv1" {
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location

  name = "${local.app_gw_name_prod}-identity"
}

resource "azurerm_role_assignment" "prodv1" {
  scope                = data.azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azurerm_user_assigned_identity.prodv1.principal_id
}
