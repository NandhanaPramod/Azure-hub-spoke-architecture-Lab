provider "azurerm" {
  features {}

}

provider "azurerm" {
  features {}

  alias           = "dns_zone"
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
}