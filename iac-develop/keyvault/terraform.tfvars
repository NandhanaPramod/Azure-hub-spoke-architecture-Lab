allow_azure_services_bypass_firewall = true
default_action                       = "Deny"
allowed_ips                          = ["80.227.101.131/32"]

# ## id of "sa_terraform@adhaauh.onmicrosoft.com" user
# ## azuread datasources do not work with sp-tf-<hub|spoke>
# ## because of missing permissions 
key_vault_admin           = "2ec87220-2efc-46e0-9d5f-545cff9b07a4"
private_dns_zone          = "privatelink.vaultcore.azure.net"
private_dns_zone_rg       = "oss_hub"
sas_rotation_function     = "sasToken"
sas_rotation_function_rg  = "oss_hub"
sas_rotation_function_app = "sasRotation-func-app"
sas_token_secret          = "BLOB-MEDIA-TOKEN"