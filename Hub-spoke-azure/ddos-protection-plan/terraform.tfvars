basename           = "hub"
location           = "eastus"
resource_group_name = "hub-rg"
vnet_name          = "hub-vnet"
address_space      = ["10.0.0.0/16"]
dns_servers        = ["168.63.129.16"]

subnets = {
  shared = {
    name           = "shared"
    address_prefix = "10.0.0.0/24"
  }
  firewall = {
    name           = "AzureFirewallSubnet"
    address_prefix = "10.0.1.0/24"
  }
}

tags = {
  Environment = "Production"
  Project     = "Hub-Spoke"
  Service     = "DDoS Protection"
} 