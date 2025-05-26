terraform {
  backend "azurerm" {
    resource_group_name  = "oss_hub"
    storage_account_name = "osstfstatehub"
    container_name       = "osstfstatehubcontainer"
    key                  = "vnet.terraform.tfstate"
  }
}