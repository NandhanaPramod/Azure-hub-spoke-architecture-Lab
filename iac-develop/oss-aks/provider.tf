provider "azurerm" {
  features {}

  alias           = "hub"
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "gitlab" {}

provider "helm" {
  debug = true
  kubernetes {
    host                   = module.aks.admin_host
    username               = module.aks.admin_username
    password               = module.aks.admin_password
    client_certificate     = base64decode(module.aks.admin_client_certificate)
    client_key             = base64decode(module.aks.admin_client_key)
    cluster_ca_certificate = base64decode(module.aks.admin_cluster_ca_certificate)
  }
}