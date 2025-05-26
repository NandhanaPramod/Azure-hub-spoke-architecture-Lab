variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "location" {
  type        = string
  description = "Region name where resources will be created"
  default     = "uaenorth"
}

variable "basename" {
  description = "Prefix used for all resources names"
  default     = "oss"
  type        = string
}

variable "environment" {
  description = "Prefix used for environment name"
  type        = string
  default     = "hub"
}

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "virtual_machines" {
  description = "List of virtual machines needs to be created in HUB"
  type = list(object({
    hostname              = string
    storage_type          = string
    subnet_name           = string
    admin_username_secret = string
    vm_size               = string
    ssh_key               = string
    data_disks = list(object({
      name         = string
      storage_type = string
      size         = number
      lun          = number
    }))
    source_image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    })
  )
  default = []
}
