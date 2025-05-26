locals {
  basename    = join("_", [var.basename, var.env])
  basename_v1 = join("_", [var.basename_v1, var.env])

  gw_vnet_name                 = join("_", [var.basename, var.env, "vnet"])
  gw_firewall_policy_name      = join("-", concat([var.basename, "waf", "nonprod"]))
  gw_firewall_policy_name_prod = join("-", concat([var.basename_v1, "waf", "prod"]))
  gw_enable_http2              = true

  app_gw_name      = join("-", concat([var.basename], ["app", "gw", "non", "prod"]))
  app_gw_name_prod = join("-", concat([var.basename_v1], ["app", "gw"]))
  # should be equal to `gateway`
  app_gw_subnet_name   = "azureapps"
  app_gw_pip_name      = join("-", concat([var.basename, "app", "gw", "nonprod", "public", "ip"]))
  app_gw_pip_name_prod = join("-", concat([var.basename_v1, "app", "gw", "prodv1", "public", "ip"]))
  tags = merge(
    var.default_tags,
    {
      Environment = upper(terraform.workspace)
      Location    = lower(data.azurerm_resource_group.this.location)
    }
  )
}
