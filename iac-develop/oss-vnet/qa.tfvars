environment           = "qa"
create_resource_group = true
backwards_compatible  = true

vnet_cidr = ["10.50.8.0/22", "10.50.32.0/23"]

security_rules = [
  {
    name                       = "ssh-in"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.50.1.32/27"
    destination_address_prefix = "*"
  },
  {
    name                       = "rdp-in"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "10.50.1.32/27"
    destination_address_prefix = "*"
  },
  {
    name                       = "Port_443"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  },
  {
    name                       = "Port_3443"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  },
  {
    name                       = "Allow_All_ADHA"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
]

security_group = [
  {
    "name" : "spare",
    "rule" : ["ssh-in", "rdp-in"],
  },
  {
    "name" : "web",
    "rule" : ["ssh-in", "rdp-in"],
  },
  {
    "name" : "api",
    "rule" : ["ssh-in", "rdp-in", "Port_3443", "Port_443"],
  },
  {
    "name" : "database",
    "rule" : ["ssh-in", "rdp-in"],
  },
  {
    "name" : "application",
    "rule" : ["ssh-in", "rdp-in", "Allow_All_ADHA"],
  },
  {
    "name" : "azureapps",
    "rule" : ["ssh-in", "rdp-in"],
  }
]

vnet_subnets = [
  {
    name              = "spare"
    address_prefixes  = ["10.50.8.0/26"]
    security_group    = "spare"
    service_endpoints = []
    # Careful with this, the route_table value should match azurerm_route_table.this.name, null otherwise
    route_table = null
  },
  {
    name              = "web"
    address_prefixes  = ["10.50.8.64/26"]
    security_group    = "web"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Storage"]
    # Before adding route_table to subnet make sure you got the route_table name right from azurerm_route_table.this.name (resource)
    route_table = "routing"
  },
  {
    name              = "api"
    address_prefixes  = ["10.50.8.128/26"]
    security_group    = "api"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.ServiceBus"]
    route_table       = "routing"
  },
  {
    name              = "database"
    address_prefixes  = ["10.50.8.192/26"]
    security_group    = "database"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.ServiceBus"]
    route_table       = "routing"
  },
  {
    name              = "application"
    address_prefixes  = ["10.50.9.0/25"]
    security_group    = "application"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Sql", "Microsoft.Storage"]
    route_table       = "routing"
  },
  {
    name              = "k8sapplication"
    address_prefixes  = ["10.50.32.0/23"]
    security_group    = "application"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Sql", "Microsoft.Storage"]
    route_table       = "routing"
  },
  {
    name              = "azureapps"
    address_prefixes  = ["10.50.9.128/26"]
    security_group    = "azureapps"
    service_endpoints = ["Microsoft.KeyVault", "Microsoft.ServiceBus"]
    route_table       = null
  },
]

# Routing table routes.
# Naming convention supports only one name_prefix and multiple name_postfix(es)
routes = [
  {
    name_prefix            = "Default"
    name_postfix           = ["Az", "Cloud"]
    address_prefix         = "AzureCloud.uaenorth"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name_prefix            = "Default"
    name_postfix           = ["Az", "Containerregistry"]
    address_prefix         = "AzureContainerRegistry.UAENorth"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name_prefix            = "Default"
    name_postfix           = ["Az", "Apimanagement"]
    address_prefix         = "ApiManagement.UAENorth"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name_prefix            = "Default"
    name_postfix           = ["Az", "Keyvault"]
    address_prefix         = "AzureKeyVault.UAENorth"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name_prefix            = "Default"
    name_postfix           = ["Az", "Servicebus"]
    address_prefix         = "ServiceBus.UAENorth"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name_prefix            = "Default"
    name_postfix           = ["Az", "Servicebus", "Westeurope"]
    address_prefix         = "ServiceBus.WestEurope"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name_prefix            = "Default"
    name_postfix           = ["Az", "Storage"]
    address_prefix         = "Storage.UAENorth"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  },
  {
    name_prefix            = "Default"
    name_postfix           = ["Route"]
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.50.0.68"
  }
]
