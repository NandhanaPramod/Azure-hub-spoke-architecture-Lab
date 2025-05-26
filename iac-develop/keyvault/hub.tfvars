# basename              = "iskan"

backwards_compatible  = true
create_resource_group = true

keyvault_sku                   = "standard"
soft_delete_retention_days     = 7
virtual_network_name           = "oss_hub_vnet"
subnet_names                   = ["azureapps", "database", "devops", "spare"]
virtual_network_resource_group = "oss_hub"
action_group                   = "oss-hub-prod-alerts"
prod_diagnostic_settings       = true

# app-gw needs to read certificate secret when applying tf. 
# the runner that applies app-gw needs to be able to read data from keyvault
# without the wildcard. that is forbidden and gw pipeline fails
allowed_ips              = ["80.227.101.131/32"]
purge_protection_enabled = true
private_link_subnet_name = "devops"
managed_identity_with_secrets_permission = {
  "aad-pod-id-dev"      = "2a88c89a-011a-4129-a14c-4cfe7b7a7c54"
  "aad-pod-id-qa"       = "a7a060b9-f37b-4874-ac1b-d9099f6f3869"
  "aad-pod-id-qa2"      = "e01ef267-f40f-4a7f-b44e-ffadd801d03c"
  "aad-pod-id-qa3"      = "e2589317-4cc4-43f7-b9eb-81abfd12f7cd"
  "aad-pod-id-qa3-cba"  = "f445178d-34f7-4bcc-904e-0ca6d6348412"
  "aad-pod-id-pp"       = "8a0e0dbd-a3e8-4b0d-89a9-622413a3e06b"
  "aad-pod-id-prod"     = "a58bc059-0404-42fa-873f-797216f1fe67"
  "aad-pod-id-pp-cba"   = "430741df-0428-4d0d-a0f8-4dbf5af5b3b8"
  "aad-pod-id-prod-cba" = "30ae2697-8e00-43fa-a8ee-9650d7765ed2"
}
managed_identity_with_certs_permission = {
  "aad-pod-id-dev"      = "2a88c89a-011a-4129-a14c-4cfe7b7a7c54"
  "aad-pod-id-qa"       = "a7a060b9-f37b-4874-ac1b-d9099f6f3869"
  "aad-pod-id-qa2"      = "e01ef267-f40f-4a7f-b44e-ffadd801d03c"
  "aad-pod-id-qa3"      = "e2589317-4cc4-43f7-b9eb-81abfd12f7cd"
  "aad-pod-id-qa3-cba"  = "f445178d-34f7-4bcc-904e-0ca6d6348412"
  "aad-pod-id-pp"       = "8a0e0dbd-a3e8-4b0d-89a9-622413a3e06b"
  "aad-pod-id-prod"     = "a58bc059-0404-42fa-873f-797216f1fe67"
  "aad-pod-id-pp-cba"   = "430741df-0428-4d0d-a0f8-4dbf5af5b3b8"
  "aad-pod-id-prod-cba" = "30ae2697-8e00-43fa-a8ee-9650d7765ed2"
}
