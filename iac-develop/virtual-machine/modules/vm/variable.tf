variable "hostname" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "subnet_id" {
  type = string
}

variable "storage_type" {
  type = string
}

variable "os_disk_size" {
  type = number
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_keys" {
  type = string
}

variable "data_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "data_disks" {
  type = list(object({
    name         = string
    storage_type = string
    size         = number
    lun          = number
  }))
  default = []
}

variable "source_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}
