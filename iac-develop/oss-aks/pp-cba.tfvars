basename = "iskan"

# Subnet
resource_group_name = "iskan_pp"
vnet_subnet_name    = "iskan_pp_dhp_application"
vnet_name           = "iskan_pp_vnet"
# AKS
env                                 = "pp-cba"
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

secret_rotation_enabled     = true
secret_rotation_interval    = "10s"
persistent_sa_role_required = true

usernodepool = [
  {
    usernodepool_name          = "b4msagentnp",
    useragents_min_count       = 1
    useragents_max_count       = 2
    useragents_max_pods        = 55
    useragents_vm_size         = "Standard_B4ms"
    useragents_os_disk_size_gb = 128
    useragents_labels          = { "nplabel" : "b4msagentnp" }
  },
  {
    usernodepool_name          = "d8sv4agentnp",
    useragents_min_count       = 1
    useragents_max_count       = 3
    useragents_max_pods        = 70
    useragents_vm_size         = "Standard_D8s_v4"
    useragents_os_disk_size_gb = 128
    useragents_labels          = { "nplabel" : "d8sv4agentnp" }
  }
]

acr_name                = "osshubcontainerregistry"
acr_resource_group_name = "oss-hub-container-registry-rg"
akv_name                = "iskan-pp-keyvault"
akv_resource_group_name = "iskan_pp"
action_group            = "iskan-pp-infra-alerts"
deployments             = ["ms-federation", "ms-cron", "ms-channel", "ms-document", "ms-integration"]
deployment_alerts = [{
  name                    = "DeploymentCpuUtilization"
  evaluation_frequency    = "PT15M"
  target_group            = ["infra"]
  severity                = 2
  window_duration         = "PT15M"
  description             = "Alert if CPU Utilization Percentage >=70"
  operator                = "GreaterThanOrEqual"
  query                   = <<-Query
  Perf
| where ObjectName == "K8SContainer" and CounterName == "cpuUsageNanoCores"
| extend PodUid = tostring(split(InstanceName, "/")[-2]), CPUUsage = toint(CounterValue)
| join (KubePodInventory
    | where ControllerName has "deployment-name-here")
    on PodUid
| join (Perf
    | where CounterName == "cpuRequestNanoCores"
    | extend PodUid = tostring(split(InstanceName, "/")[-2]), CPURequest = toint(CounterValue))
    on PodUid
| summarize UsedPercent = avg(CPUUsage) *100.0 / avg(CPURequest)
  Query
  threshold               = 70
  time_aggregation_method = "Total"
  metric_measure_column   = "UsedPercent"
  },
  {
    name                    = "DeploymentMemoryUtilization"
    evaluation_frequency    = "PT15M"
    target_group            = ["infra"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if Memory Utilization Percentage >=70"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
  Perf
| where ObjectName == "K8SContainer" and CounterName == "memoryRssBytes"
| extend PodUid = tostring(split(InstanceName, "/")[-2]), memoryRssBytesUsage = toint(CounterValue)
| join (KubePodInventory
        | where ControllerName has "deployment-name-here")
        on PodUid
| join (Perf
        | where CounterName == "memoryRequestBytes"
        | extend PodUid = tostring(split(InstanceName, "/")[-2]), MemoryRequest = toint(CounterValue))
        on PodUid
| summarize UsedPercent = avg(memoryRssBytesUsage) *100.0 / avg(MemoryRequest)
  Query
    threshold               = 70
    time_aggregation_method = "Total"
    metric_measure_column   = "UsedPercent"
}]
