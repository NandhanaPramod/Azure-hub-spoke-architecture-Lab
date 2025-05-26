basename = "iskan"

# Subnet
resource_group_name = "iskan_prod"
vnet_subnet_name    = "iskan_prod_application"
vnet_name           = "iskan_prod_vnet"
# AKS
env                                 = "prod"
agents_availability_zones           = ["1", "2", "3"]
sysagents_max_count                 = 1
sysagents_min_count                 = 1
sysagents_max_pods                  = 31
agents_type                         = "VirtualMachineScaleSets"
net_profile_dns_service_ip          = "10.0.0.10"
net_profile_docker_bridge_cidr      = "172.17.0.1/16"
net_profile_service_cidr            = "10.0.0.0/16"
sysagents_os_disk_size_gb           = 128
rbac_aad_admin_group_object_ids     = ["674f243e-7937-497d-9796-0281623693eb", "dcac2983-c296-4474-90d0-631885563f7f"]
identity_type                       = "SystemAssigned"
ingress_application_gateway_enabled = false
key_vault_secrets_provider_enabled  = true

secret_rotation_enabled  = true
secret_rotation_interval = "10s"

usernodepool = [
  {
    usernodepool_name          = "d16sv4agent",
    useragents_min_count       = 4
    useragents_max_count       = 6
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
app_action_group        = "iskan-prod-app-alerts"

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
  },
  {
    name                    = "CommandFailure"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if Command failure log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "error Command failed with exit code"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "ORM_ERROR"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if DB Connection Issue log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "ORM_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "QUERY_FAILED"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if DB Query Failed log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "QUERY_FAILED"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "ApplicationCrash"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if Application Crash (UncaughtException or UnhandledRejection) log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "UncaughtException" or LogEntry contains "UnhandledRejection"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "RedisError"
    evaluation_frequency    = "PT15M"
    target_group            = ["infra"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if RedisError (REDIS_ERROR) log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "REDIS_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "StaticStorageRefreshFailed"
    evaluation_frequency    = "PT15M"
    target_group            = ["infra"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if Static Storage Refresh Failed log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "Fetching from BLOB_CONTENT Failed"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "AppConfigRefreshFailed"
    evaluation_frequency    = "PT15M"
    target_group            = ["infra"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if App Config Refresh Failed log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "Fetching from APP_CONFIG Failed"
| summarize Total = count()
  Query
    threshold               = 3
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "OnEveryRequestPodCreated"
    evaluation_frequency    = "PT15M"
    target_group            = ["infra"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if Application Start log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "Nest application successfully started"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "EmailQueueError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if Email Queue Error log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "EMAIL_QUEUE_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "PDFQueueError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if PDF Queue Error log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "PDF_QUEUE_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "PushQueueError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if Push Queue Error log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "PUSH_QUEUE_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "SMSQueueError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if SMS Queue Error log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "SMS_QUEUE_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "RequestTimeout"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if Request Timeout log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "REQUEST_TIMEOUT"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "ELMSQueueError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if ELMS Queue Error log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "ELMS_QUEUE_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "PCError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if PC requested failure > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "PC_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "DMTError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if DMT_ERROR > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "DMT_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "ExtQueueError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if EXT Queue Error log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "EXT_QUEUE_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "GisQueueError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if GIS Queue Error log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "GIS_QUEUE_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "DocQueueError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if DOC Queue Error log count > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "DOC_QUEUE_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "ECMError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if ECM_ERROR > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "ECM_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "FABError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if FAB_ERROR > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "FAB_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "ADSGError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if ADSG_ERROR > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "ADSG_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  },
  {
    name                    = "ADDCError"
    evaluation_frequency    = "PT15M"
    target_group            = ["app"]
    severity                = 2
    window_duration         = "PT15M"
    description             = "Alert if ADDC_ERROR > 0"
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
let nonRunningPods = (KubePodInventory | where PodStatus has "Terminating"| project PodUid);
let containers = KubePodInventory
| where Name has "deployment-name-here" and PodUid !in (nonRunningPods)
| distinct ContainerID;
ContainerLog
| where ContainerID in (containers)
| filter LogEntry contains "ADDC_ERROR"
| summarize Total = count()
  Query
    threshold               = 1
    time_aggregation_method = "Total"
    metric_measure_column   = "Total"
  }
]
