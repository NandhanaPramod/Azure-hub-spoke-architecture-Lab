resource "azurerm_network_interface" "this" {
  name                          = "${var.hostname}-nic"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tags                          = var.tags
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                            = var.hostname
  resource_group_name             = var.resource_group_name
  location                        = var.location
  tags                            = var.tags
  size                            = var.vm_size
  disable_password_authentication = true
  admin_username                  = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_keys
  }

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  os_disk {
    name                 = "${var.hostname}-disk-OS"
    caching              = "ReadWrite"
    storage_account_type = var.storage_type
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
    publisher = var.source_image.publisher
    offer     = var.source_image.offer
    sku       = var.source_image.sku
    version   = var.source_image.version
  }

}

resource "azurerm_managed_disk" "this" {
  for_each             = { for disk in var.data_disks : disk.name => disk }
  name                 = "${var.hostname}-disk-${each.key}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  tags                 = var.tags
  storage_account_type = each.value.storage_type
  disk_size_gb         = each.value.size
  create_option        = "Empty"
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  for_each           = { for disk in var.data_disks : disk.name => disk }
  virtual_machine_id = azurerm_linux_virtual_machine.this.id
  managed_disk_id    = azurerm_managed_disk.this[each.key].id
  lun                = each.value.lun
  caching            = var.data_disk_caching
}
