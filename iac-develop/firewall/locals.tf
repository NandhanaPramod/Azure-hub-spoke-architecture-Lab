locals {
  basename = join("_", [var.basename, var.environment])
  tags = merge(
    var.default_tags,
    {
      Environment  = upper(var.environment)
      Location     = lower(data.azurerm_resource_group.this.location)
      ServiceClass = "prod"
    }
  )
  subnet_name = "AzureFirewallSubnet" # "Due to Terraform limitation, firewall subnet name must be AzureFirewallSubnet and it does not take this value: azurefirewallsubnet"
}