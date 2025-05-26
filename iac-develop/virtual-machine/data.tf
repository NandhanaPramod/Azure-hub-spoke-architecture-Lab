data "azurerm_resource_group" "this" {
  name = local.basename
}

data "azurerm_subnet" "this" {
  for_each             = { for vm in var.virtual_machines : vm.hostname => vm }
  name                 = each.value.subnet_name
  virtual_network_name = "${local.basename}_vnet"
  resource_group_name  = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault" "this" {
  name                = local.keyvault_name
  resource_group_name = local.keyvault_resource_group_name
}

data "azurerm_key_vault_secret" "vm_admin_username" {
  for_each     = { for vm in var.virtual_machines : vm.hostname => vm }
  name         = each.value.admin_username_secret
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_ssh_public_key" "this" {
  for_each            = { for vm in var.virtual_machines : vm.hostname => vm }
  name                = each.value.ssh_key
  resource_group_name = data.azurerm_resource_group.this.name
}

