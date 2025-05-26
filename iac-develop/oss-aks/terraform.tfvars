# Common AKS - core infra
# Only update when base k8s cluster either needs to upgrade or make changed related to core Infra 
kubernetes_master_version         = "1.25.6"
kubernetes_agent_version          = "1.25.6"
azure_policy_enabled              = true
enable_auto_scaling               = true
enable_host_encryption            = false
http_application_routing_enabled  = false
role_based_access_control_enabled = true
local_account_disabled            = false
network_plugin                    = "azure"
network_policy                    = "azure"
private_cluster_enabled           = false
rbac_aad_managed                  = true
sku_tier                          = "Paid"
open_service_mesh_enabled         = true
sysagents_pool_name               = "sysnodepool"
# Enabled logging
log_analytics_workspace_enabled = true
deployments                     = ["ms-federation", "ms-consumer-queue", "ms-document", "ms-elms", "ms-gis", "ms-producer-queue", "ms-user", "ms-cron", "ms-external"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
    target_group            = ["infra"]
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
# Restrict Kubernetes API server 
api_server_authorized_ip_ranges = ["80.227.101.131/32", "20.216.60.157/32", "40.120.112.56/30", "94.203.133.25/32"]
required_preview_features       = ["EnableBlobCSIDriver", "AKS-AzureDefender", "AKS-KedaPreview"]