data "azurerm_client_config" "this" {}

data "azurerm_subnet" "this" {
  name                 = var.vnet_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_container_registry" "this" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name

  provider = azurerm.hub
}

data "azurerm_key_vault" "this" {
  name                = var.akv_name
  resource_group_name = var.akv_resource_group_name
}

data "azurerm_storage_account" "this" {
  for_each            = { for account in local.storage_account_contributor_access : account.type => account if account.required }
  name                = each.value.name
  resource_group_name = var.resource_group_name
}

resource "null_resource" "register_features" {
  triggers = {
    features = join(",", var.required_preview_features)
    provider = "Microsoft.ContainerService"
  }
  provisioner "local-exec" {
    command = <<EOT
      az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
      az account set --subscription $ARM_SUBSCRIPTION_ID
      for feature in $(echo ${self.triggers.features} | sed "s/,/ /g")
      do
        az feature register --namespace ${self.triggers.provider} --name $feature
      done
    EOT
  }
}

module "aks" {
  source = "git::https://github.com/Azure/terraform-azurerm-aks.git?ref=5.0.0"

  prefix                                      = "${var.basename}-${var.env}"
  kubernetes_version                          = var.kubernetes_master_version
  orchestrator_version                        = var.kubernetes_agent_version
  resource_group_name                         = var.resource_group_name
  agents_availability_zones                   = var.agents_availability_zones
  agents_max_count                            = var.sysagents_max_count
  agents_max_pods                             = var.sysagents_max_pods
  agents_min_count                            = var.sysagents_min_count
  agents_pool_name                            = var.sysagents_pool_name
  agents_type                                 = var.agents_type
  agents_tags                                 = local.sysagents_tags
  agents_labels                               = local.sysagents_labels
  azure_policy_enabled                        = var.azure_policy_enabled
  enable_auto_scaling                         = var.enable_auto_scaling
  enable_host_encryption                      = var.enable_host_encryption
  http_application_routing_enabled            = var.http_application_routing_enabled
  log_analytics_workspace_enabled             = var.log_analytics_workspace_enabled
  role_based_access_control_enabled           = var.role_based_access_control_enabled
  local_account_disabled                      = var.local_account_disabled
  net_profile_dns_service_ip                  = var.net_profile_dns_service_ip
  net_profile_docker_bridge_cidr              = var.net_profile_docker_bridge_cidr
  net_profile_service_cidr                    = var.net_profile_service_cidr
  network_plugin                              = var.network_plugin
  network_policy                              = var.network_policy
  os_disk_size_gb                             = var.sysagents_os_disk_size_gb
  private_cluster_enabled                     = var.private_cluster_enabled
  rbac_aad_managed                            = var.rbac_aad_managed
  sku_tier                                    = var.sku_tier
  vnet_subnet_id                              = data.azurerm_subnet.this.id
  open_service_mesh_enabled                   = var.open_service_mesh_enabled
  rbac_aad_admin_group_object_ids             = var.rbac_aad_admin_group_object_ids
  identity_type                               = var.identity_type
  ingress_application_gateway_enabled         = var.ingress_application_gateway_enabled
  ingress_application_gateway_id              = var.ingress_application_gateway_id
  key_vault_secrets_provider_enabled          = var.key_vault_secrets_provider_enabled
  log_analytics_workspace_resource_group_name = local.monitor_resource_group_name
  api_server_authorized_ip_ranges             = var.api_server_authorized_ip_ranges
  log_analytics_workspace = {
    id   = data.azurerm_log_analytics_workspace.this.id
    name = local.log_analytics_workspace_name
  }


  secret_rotation_enabled  = var.secret_rotation_enabled
  secret_rotation_interval = var.secret_rotation_interval

  tags = local.tags
}

resource "null_resource" "enable_osm" {
  depends_on = [
    module.aks
  ]
  triggers = {
    aks_id                           = module.aks.aks_id
    aks_name                         = "${var.basename}-${var.env}-aks"
    aks_resource_group               = var.resource_group_name
    osm_sidecar_proxy_request_memory = "100Mi"
    osm_sidecar_proxy_request_cpu    = "16m"
    osm_sidecar_proxy_limit_memory   = "300Mi"
    osm_sidecar_proxy_limit_cpu      = "300m"
  }
  provisioner "local-exec" {
    command = <<EOT
      az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
      az account set --subscription $ARM_SUBSCRIPTION_ID
      osm_enabled=`az aks addon list --name ${self.triggers.aks_name} --resource-group ${self.triggers.aks_resource_group} | jq '.|any(.name == "open-service-mesh")'`
      if [[ "$osm_enabled" == "true" ]]; then
        echo "OSM already enabled. Proceeding with the next steps."
      else
        echo "Enabling OSM."
        az aks enable-addons --resource-group ${self.triggers.aks_resource_group} --name ${self.triggers.aks_name} --addons open-service-mesh
      fi
      az aks get-credentials --resource-group ${self.triggers.aks_resource_group} --name ${self.triggers.aks_name} --admin
      osm namespace add default
      kubectl patch meshconfig osm-mesh-config -n kube-system -p '{"spec":{"traffic":{"enablePermissiveTrafficPolicyMode":false}}}'  --type=merge
      kubectl patch meshconfig osm-mesh-config -n kube-system -p '{"spec":{"sidecar":{"resources":{"limits":{"cpu":"${self.triggers.osm_sidecar_proxy_limit_cpu}","memory":"${self.triggers.osm_sidecar_proxy_limit_memory}"},"requests":{"cpu":"${self.triggers.osm_sidecar_proxy_request_cpu}","memory":"${self.triggers.osm_sidecar_proxy_request_memory}"}}}}}'  --type=merge
    EOT
  }
}

resource "null_resource" "this" {
  depends_on = [
    null_resource.register_features
  ]
  triggers = {
    aks_id             = module.aks.aks_id
    aks_name           = "${var.basename}-${var.env}-aks"
    aks_resource_group = var.resource_group_name
  }
  provisioner "local-exec" {
    command = <<EOT
      az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
      az account set --subscription $ARM_SUBSCRIPTION_ID
      az aks update --yes --enable-blob-driver -n ${self.triggers.aks_name} -g ${self.triggers.aks_resource_group}
    EOT
  }
}

resource "null_resource" "enable_keda" {
  depends_on = [
    null_resource.register_features
  ]
  triggers = {
    aks_id             = module.aks.aks_id
    aks_name           = "${var.basename}-${var.env}-aks"
    aks_resource_group = var.resource_group_name
  }
  provisioner "local-exec" {
    command = <<EOT
      az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
      az account set --subscription $ARM_SUBSCRIPTION_ID
      az aks update --yes --enable-keda -n ${self.triggers.aks_name} -g ${self.triggers.aks_resource_group}
    EOT
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "usernodepool" {
  for_each = {
    for np in var.usernodepool : np.usernodepool_name => np
  }
  name                  = each.value.usernodepool_name
  orchestrator_version  = var.kubernetes_agent_version
  kubernetes_cluster_id = module.aks.aks_id
  vnet_subnet_id        = data.azurerm_subnet.this.id
  enable_auto_scaling   = var.enable_auto_scaling
  zones                 = var.agents_availability_zones
  min_count             = each.value.useragents_min_count
  max_count             = each.value.useragents_max_count
  max_pods              = each.value.useragents_max_pods
  mode                  = "User"
  vm_size               = each.value.useragents_vm_size
  os_disk_size_gb       = each.value.useragents_os_disk_size_gb
  os_disk_type          = "Managed"
  tags                  = local.useragents_tags
  node_labels           = each.value.useragents_labels

  depends_on = [module.aks]
}

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = "aad-pod-id-${var.env}"
}

data "azurerm_resource_group" "this" {
  name = module.aks.node_resource_group
}

resource "gitlab_group_variable" "this" {
  group             = "ps-oss"
  key               = "TF_VAR_kubeconfig"
  value             = module.aks.kube_admin_config_raw
  protected         = false
  masked            = false
  variable_type     = "file"
  environment_scope = var.env
}

resource "helm_release" "identity" {
  name        = "aks-pod-identity"
  repository  = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart       = "aad-pod-identity"
  version     = "4.1.12"
  namespace   = "kube-system"
  max_history = 3
  # TODO: set wait to false until isuse with aad pods in pending state is fixed
  wait = false

  values = [local.pod_identity_values]

  set {
    name  = "mic.podAnnotations.checksum"
    value = local.pod_identity_values_hash
  }

  set {
    name  = "nmi.podAnnotations.checksum"
    value = local.pod_identity_values_hash
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${var.basename}-${var.env}-aks-diagnostic-setting"
  target_resource_id         = module.aks.aks_id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.logs
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.metrics
    content {
      category = metric.value
    }
  }
}

resource "azurerm_monitor_metric_alert" "nodepool_cpu_alert" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.usernodepool
  ]
  for_each            = toset([for pool in local.nodepools : pool.usernodepool_name])
  name                = "${var.basename}-${var.env}-${each.value}-cpu-alert"
  resource_group_name = var.resource_group_name
  scopes              = [module.aks.aks_id]
  description         = "Alert when ${var.basename}-${var.env}-aks' ${each.value} nodepool's CPU usage >=70%"
  frequency           = "PT15M"
  severity            = 2
  window_size         = "PT15M"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThanOrEqual"
    threshold        = "70"
    dimension {
      name     = "nodepool"
      operator = "Include"
      values   = [each.value]
    }
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "nodepool_mem_working_set_alert" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.usernodepool
  ]
  for_each            = toset([for pool in local.nodepools : pool.usernodepool_name])
  name                = "${var.basename}-${var.env}-${each.value}-mem-working-set-alert"
  resource_group_name = var.resource_group_name
  scopes              = [module.aks.aks_id]
  description         = "Alert when ${var.basename}-${var.env}-aks' ${each.value} nodepool's memory working set usage >=70%"
  frequency           = "PT15M"
  severity            = 2
  window_size         = "PT15M"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_memory_working_set_percentage"
    aggregation      = "Average"
    operator         = "GreaterThanOrEqual"
    threshold        = "70"
    dimension {
      name     = "nodepool"
      operator = "Include"
      values   = [each.value]
    }
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "nodepool_mem_rss_alert" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.usernodepool
  ]
  for_each            = toset([for pool in local.nodepools : pool.usernodepool_name])
  name                = "${var.basename}-${var.env}-${each.value}-mem-rss-alert"
  resource_group_name = var.resource_group_name
  scopes              = [module.aks.aks_id]
  description         = "Alert when ${var.basename}-${var.env}-aks' ${each.value} nodepool's memory rss set usage >=70%"
  frequency           = "PT15M"
  severity            = 2
  window_size         = "PT15M"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_memory_rss_percentage"
    aggregation      = "Average"
    operator         = "GreaterThanOrEqual"
    threshold        = "70"
    dimension {
      name     = "nodepool"
      operator = "Include"
      values   = [each.value]
    }
  }

  tags = local.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "this" {
  for_each                = { for alert in local.deployment_alerts : "${alert.name}-${alert.deployment}" => alert }
  name                    = "${var.basename}-${var.env}-aks-${each.value.name}-${each.value.deployment}"
  resource_group_name     = var.resource_group_name
  location                = var.location
  evaluation_frequency    = each.value.evaluation_frequency
  scopes                  = [module.aks.aks_id]
  severity                = each.value.severity
  window_duration         = each.value.window_duration
  description             = each.value.description
  display_name            = "${var.basename}-${var.env}-aks-${each.value.name}-${each.value.deployment}"
  auto_mitigation_enabled = true

  action {
    action_groups = compact([
      contains(each.value.target_group, "app") && var.app_action_group != null ? data.azurerm_monitor_action_group.app[0].id : null,
      contains(each.value.target_group, "infra") ? data.azurerm_monitor_action_group.this.id : null
    ])
  }
  criteria {
    operator                = each.value.operator
    query                   = replace(each.value.query, "deployment-name-here", each.value.deployment)
    threshold               = each.value.threshold
    time_aggregation_method = each.value.time_aggregation_method
    metric_measure_column   = each.value.metric_measure_column
  }

  tags = local.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "node_autoscale_alerts" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.usernodepool
  ]
  for_each                = { for pool in local.nodepools : pool.usernodepool_name => pool if pool.useragents_max_count - pool.useragents_min_count >= 1 }
  name                    = "${var.basename}-${var.env}-aks-${each.value.usernodepool_name}-autoscale-alert"
  resource_group_name     = var.resource_group_name
  location                = var.location
  evaluation_frequency    = "PT15M"
  scopes                  = [module.aks.aks_id]
  severity                = 2
  window_duration         = "PT15M"
  description             = "Alert when ${var.basename}-${var.env}-aks' ${each.value.usernodepool_name} nodepool's VM count >=80% of max capacity"
  display_name            = "${var.basename}-${var.env}-aks-${each.value.usernodepool_name}-autoscale-alert"
  auto_mitigation_enabled = true
  action {
    action_groups = [data.azurerm_monitor_action_group.this.id]
  }
  criteria {
    operator                = "GreaterThanOrEqual"
    query                   = "KubeNodeInventory| where Computer has \"${each.value.usernodepool_name}\" | distinct Computer | summarize UsedPercent = count() *100.0 / ${each.value.useragents_max_count}"
    threshold               = 80
    time_aggregation_method = "Total"
    metric_measure_column   = "UsedPercent"
  }

  tags = local.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "hpa_autoscale_alerts" {
  for_each                = var.hpa_alert_enabled ? toset(var.deployments) : toset([])
  name                    = "${var.basename}-${var.env}-aks-${each.value}-autoscale-alert"
  resource_group_name     = var.resource_group_name
  location                = var.location
  evaluation_frequency    = "PT15M"
  scopes                  = [module.aks.aks_id]
  severity                = 2
  window_duration         = "PT15M"
  description             = "Alert when ${var.env} ${each.value} pod count >=80% of max capacity"
  display_name            = "${var.basename}-${var.env}-aks-${each.value}-autoscale-alert"
  auto_mitigation_enabled = true
  action {
    action_groups = [data.azurerm_monitor_action_group.this.id]
  }
  criteria {
    operator                = "GreaterThanOrEqual"
    query                   = <<-Query
InsightsMetrics| where Name == "kube_hpa_status_current_replicas"
| extend Tags = parse_json(Tags)
| extend ClusterId = Tags["container.azm.ms/clusterId"]
| extend
  HPAs = tostring(Tags.hpa),
  Deployment = tostring(Tags.targetName),
  k8sNamespace = tostring(Tags.k8sNamespace),
  currentMin = toint(Tags.spec_min_replicas),
  currentMax =  toint(Tags.spec_max_replicas),
  currentDesired = toint(Tags.status_desired_replicas)
| where Deployment == "${each.value}"
| extend consumedReplicaCapacityPercent = currentDesired * 100.0 / currentMax
| summarize UsedPercent = avg(consumedReplicaCapacityPercent)
Query
    threshold               = 80
    time_aggregation_method = "Total"
    metric_measure_column   = "UsedPercent"
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "aks_cluster_disk_usage" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.usernodepool
  ]
  name                = "${var.basename}-${var.env}-aks-cluster-disk-usage-alert"
  resource_group_name = var.resource_group_name
  scopes              = [module.aks.aks_id]
  description         = "Alert when cluster reaches diskusage90%"
  frequency           = "PT15M"
  severity            = 1
  window_size         = "PT15M"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_disk_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = "90"
    dimension {
      name     = "nodepool"
      operator = "Include"
      values   = ["*"]
    }
  }
}

resource "azurerm_monitor_metric_alert" "aks_cluster_autoscale_health_alert" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.usernodepool
  ]
  name                = "${var.basename}-${var.env}-cluster-autoscale-health-alert"
  resource_group_name = var.resource_group_name
  scopes              = [module.aks.aks_id]
  description         = "Alert when  cluster health is unhealthy"
  frequency           = "PT15M"
  severity            = 2
  window_size         = "PT15M"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "cluster_autoscaler_cluster_safe_to_autoscale"
    aggregation      = "Total"
    operator         = "LessThan"
    threshold        = "1"
  }
}

resource "azurerm_monitor_metric_alert" "aks_cluster_unneeded_nodes" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.usernodepool
  ]
  name                = "${var.basename}-${var.env}-cluster-unneeded-nodes-alert"
  resource_group_name = var.resource_group_name
  scopes              = [module.aks.aks_id]
  description         = "Alert when cluster unneeded nodes"
  frequency           = "PT15M"
  severity            = 3
  window_size         = "PT15M"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "cluster_autoscaler_unneeded_nodes_count"
    aggregation      = "Total"
    operator         = "GreaterThanOrEqual"
    threshold        = "1"
  }
}

resource "azurerm_monitor_metric_alert" "aks_cluster_memory_usage" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.usernodepool
  ]
  name                = "${var.basename}-${var.env}-cluster-memory-usage-alert"
  resource_group_name = var.resource_group_name
  scopes              = [module.aks.aks_id]
  description         = "Alert when  cluster reaches memoryusage "
  frequency           = "PT15M"
  severity            = 1
  window_size         = "PT15M"
  action {
    action_group_id = data.azurerm_monitor_action_group.this.id
  }
  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_memory_rss_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = "80"
    dimension {
      name     = "nodepool"
      operator = "Include"
      values   = ["*"]
    }
  }
}
