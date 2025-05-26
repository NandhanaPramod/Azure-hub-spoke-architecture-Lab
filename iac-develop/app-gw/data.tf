data "azurerm_client_config" "this" {}

data "azurerm_resource_group" "this" {
  name = local.basename
}

data "azurerm_subnet" "gw_subnet" {
  name                 = local.app_gw_subnet_name
  virtual_network_name = local.gw_vnet_name
  resource_group_name  = data.azurerm_resource_group.this.name
}

data "azurerm_web_application_firewall_policy" "this" {
  name                = local.gw_firewall_policy_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_web_application_firewall_policy" "prod" {
  name                = local.gw_firewall_policy_name_prod
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault" "this" {
  name                = "oss-hub-keyvault"
  resource_group_name = "oss-hub-keyvault-rg"
}

data "azurerm_key_vault_secret" "this" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "iskan-api-uat"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "dev" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "iskan-api-dev"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "pp" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "iskan-api-pp"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "prod" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "iskan-api-prod"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "uat2" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "iskan-api-uat2"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "uat3" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "iskan-api-uat3"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "stage" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "iskan-api-stage"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "adha-root-ca-public-key" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "ADHA-ROOT-CA-PUBLIC-KEY"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "dhp-app-non-prod-cert" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "dhp-app-non-prod-cert"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "camunda-non-prod-cert" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "camunda-non-prod-cert"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "dhp-app-prod-cert" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "dhp-app-prod-cert"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "camunda-prod-cert" {
  depends_on   = [azurerm_role_assignment.sp_to_vault_secret]
  name         = "camunda-prod-cert"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_log_analytics_workspace" "prod" {
  provider            = azurerm.prod
  name                = "iskan-prod-la-workspace"
  resource_group_name = "iskan_prod"
}

