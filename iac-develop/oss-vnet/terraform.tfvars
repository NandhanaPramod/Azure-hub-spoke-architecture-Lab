location = "ukwest"
environment = "dev"
basename = "oss-spoke"

# VNet CIDR block
vnet_cidr = ["10.1.0.0/16"]

# Subnet configurations
vnet_subnets = [
  {
    name              = "app"
    address_prefixes  = ["10.1.0.0/24"]
    security_group    = "app"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.ServiceBus"]
    route_table       = "app"
  },
  {
    name              = "data"
    address_prefixes  = ["10.1.1.0/24"]
    security_group    = "data"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Sql"]
    route_table       = "data"
  },
  {
    name              = "web"
    address_prefixes  = ["10.1.2.0/24"]
    security_group    = "web"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
    route_table       = "web"
  }
]

# Security rules
security_rules = [
  {
    name                       = "AllowVnetInBound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  },
  {
    name                       = "AllowAzureLoadBalancerInBound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  },
  {
    name                       = "DenyAllInBound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

# Security groups
security_group = [
  {
    name = "app"
    rule = ["AllowVnetInBound", "AllowAzureLoadBalancerInBound", "DenyAllInBound"]
  },
  {
    name = "data"
    rule = ["AllowVnetInBound", "AllowAzureLoadBalancerInBound", "DenyAllInBound"]
  },
  {
    name = "web"
    rule = ["AllowVnetInBound", "AllowAzureLoadBalancerInBound", "DenyAllInBound"]
  }
]

# Routes
routes = [
  {
    name_prefix            = "internet"
    name_postfix           = ["route"]
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualNetworkGateway"
    next_hop_in_ip_address = null
  }
]

# DDoS protection
ddos_name = "iskan-ddos-protection-plan"
ddos_resource_group = "oss_hub"

# Resource group creation
create_resource_group = true 