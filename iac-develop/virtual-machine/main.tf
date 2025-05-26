module "virtual_machine" {
  for_each            = { for vm in var.virtual_machines : vm.hostname => vm }
  source              = "./modules/vm"
  hostname            = each.value.hostname
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  tags                = local.tags
  vm_size             = each.value.vm_size
  ssh_keys            = data.azurerm_ssh_public_key.this[each.value.hostname].public_key
  admin_username      = data.azurerm_key_vault_secret.vm_admin_username[each.value.hostname].value
  subnet_id           = data.azurerm_subnet.this[each.value.hostname].id
  os_disk_size        = 100
  storage_type        = each.value.storage_type
  data_disks          = each.value.data_disks
  source_image = {
    publisher = each.value.source_image.publisher
    offer     = each.value.source_image.offer
    sku       = each.value.source_image.sku
    version   = each.value.source_image.version
  }
}

