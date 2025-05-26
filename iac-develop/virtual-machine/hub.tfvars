backwards_compatible = true
virtual_machines = [
  {
    hostname              = "oss-dynatrace-vm-01"
    storage_type          = "StandardSSD_LRS"
    subnet_name           = "dns"
    ssh_key               = "oss-hub-dynatrace_key"
    vm_size               = "Standard_D2ls_v5"
    admin_username_secret = "dynatrace-admin-username"
    data_disks            = []
    source_image = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "84-gen2"
      version   = "latest"
    }
  },
  {
    hostname              = "oss-dynatrace-vm-02"
    storage_type          = "StandardSSD_LRS"
    subnet_name           = "dns"
    ssh_key               = "oss-hub-dynatrace_key"
    vm_size               = "Standard_D2ls_v5"
    admin_username_secret = "dynatrace-admin-username"
    data_disks            = []
    source_image = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "84-gen2"
      version   = "latest"
    }
  }
]

