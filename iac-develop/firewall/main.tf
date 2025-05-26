resource "azurerm_public_ip" "this" {
  allocation_method       = "Static"
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = var.location
  name                    = var.public_ip_name
  resource_group_name     = var.resource_group
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags                    = local.tags
  zones                   = []
}

# azurerm_firewall.this:
resource "azurerm_firewall" "this" {
  firewall_policy_id  = azurerm_firewall_policy.this.id
  location            = var.location
  name                = var.firewall_name
  resource_group_name = var.resource_group
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  tags                = local.tags
  threat_intel_mode   = var.threat_intel_mode
  zones               = []

  ip_configuration {
    name                 = azurerm_public_ip.this.name
    public_ip_address_id = azurerm_public_ip.this.id
    ## The current terraform or provder version has a Pascal Case issue that triggers the replacement of this resource.
    ##  in state we have "AzureFirewallSubnet"
    ##  in tf files we have "azurefirewallsubnet"
    ## Changing the value directly in the state has no effec, therefore the pipeline job for firewall has been disabled
    subnet_id = data.azurerm_subnet.this.id
  }
}

resource "azurerm_firewall_policy" "this" {
  location                 = var.location
  name                     = "${var.firewall_name}-policy"
  resource_group_name      = var.resource_group
  sku                      = var.sku_tier
  threat_intelligence_mode = var.threat_intel_mode

  dns {
    proxy_enabled = true
    servers = [
      "10.50.1.28",
    ]
  }

  insights {
    default_log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
    enabled                            = true
    retention_in_days                  = 30

    log_analytics_workspace {
      firewall_location = var.location
      id                = data.azurerm_log_analytics_workspace.this.id
    }
  }

  intrusion_detection {
    mode           = "Off"
    private_ranges = []
  }

  tags = local.tags
}