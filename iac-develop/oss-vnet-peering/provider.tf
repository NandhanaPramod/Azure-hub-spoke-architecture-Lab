provider "azurerm" {
  features {}

  # Details for Hub
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
}

provider "azurerm" {
  features {}

  alias = "site_spoke"
}