backwards_compatible = true
# Subnet
resource_group_name = "oss_qa"
vnet_subnet_name    = "oss_qa_k8sapplication"
vnet_name           = "oss_qa_vnet"
# AKS
env                                 = "qa"
agents_availability_zones           = ["1", "2", "3"]
sysagents_max_count                 = 2
sysagents_min_count                 = 1
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
    usernodepool_name          = "b4msagentnp",
    useragents_min_count       = 1
    useragents_max_count       = 2
    useragents_max_pods        = 20
    useragents_vm_size         = "Standard_B4ms"
    useragents_os_disk_size_gb = 128
    useragents_labels          = { "nplabel" : "b4msagentnp" }
  },
  {
    usernodepool_name          = "d8sv4agentnp",
    useragents_min_count       = 1
    useragents_max_count       = 3
    useragents_max_pods        = 35
    useragents_vm_size         = "Standard_D8s_v4"
    useragents_os_disk_size_gb = 128
    useragents_labels          = { "nplabel" : "d8sv4agentnp" }
  }
]

acr_name                    = "osshubcontainerregistry"
acr_resource_group_name     = "oss-hub-container-registry-rg"
akv_name                    = "oss-qa-keyvault"
akv_resource_group_name     = "oss-qa-keyvault-rg"
action_group                = "oss-qa-infra-alerts"
hpa_alert_enabled           = false
persistent_sa_role_required = true