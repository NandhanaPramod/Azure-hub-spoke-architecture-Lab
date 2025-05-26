function_name           = "sasRotation"
os_type                 = "Linux"
sku_name                = "EP1"
storage_account_name    = "osshubfunction"
app_insights_name       = "oss-hub-app-insights"
virtual_network_name    = "oss_hub_vnet"
subnet_name             = "azurefunction"
file_share_name         = "sas-token-file-share"
app_insights_rg         = "oss-hub-monitor-rg"
log_analytics_workspace = "oss-hub-la-workspace"
action_group            = "oss-hub-prod-alerts"
monitored_strings = {
  success = "Secret Rotated Successfully",
  failure = "EXCEPTION"
}
allowed_ips = {
  "100" = "80.227.101.131/32"
}