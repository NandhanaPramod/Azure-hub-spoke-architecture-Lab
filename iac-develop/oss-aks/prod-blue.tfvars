basename = "iskan"

# Subnet
resource_group_name = "iskan_prod"
vnet_subnet_name    = "iskan_prod_application_blue"
vnet_name           = "iskan_prod_vnet"
# AKS
env                                 = "prod-blue"
agents_availability_zones           = ["1", "2", "3"]
sysagents_max_count                 = 3
sysagents_min_count                 = 2
sysagents_max_pods                  = 31
agents_type                         = "VirtualMachineScaleSets"
net_profile_dns_service_ip          = "10.0.0.10"
net_profile_docker_bridge_cidr      = "172.17.0.1/16"
net_profile_service_cidr            = "10.0.0.0/16"
sysagents_os_disk_size_gb           = 128
rbac_aad_admin_group_object_ids     = ["674f243e-7937-497d-9796-0281623693eb"]
identity_type                       = "SystemAssigned"
ingress_application_gateway_enabled = false
key_vault_secrets_provider_enabled  = true

secret_rotation_enabled  = true
secret_rotation_interval = "10s"

usernodepool = [
  {
    usernodepool_name          = "d16sv4agent",
    useragents_min_count       = 4
    useragents_max_count       = 13
    useragents_max_pods        = 30
    useragents_vm_size         = "Standard_D16s_v4"
    useragents_os_disk_size_gb = 128
    useragents_labels          = { "nplabel" : "d16sv4agent" }
  }
]

acr_name                = "osshubcontainerregistry"
acr_resource_group_name = "oss-hub-container-registry-rg"
akv_name                = "iskan-prod-keyvault"
akv_resource_group_name = "iskan_prod"
action_group            = "iskan-prod-infra-alerts"