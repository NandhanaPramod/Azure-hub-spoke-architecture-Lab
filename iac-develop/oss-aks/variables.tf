variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "basename" {
  description = "Prefix used for all resources names"
  type        = string
  default     = "oss"
}

variable "env" {
  description = "Prefix used for environment name"
  type        = string
}

variable "kubernetes_master_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  type        = string
}

variable "kubernetes_agent_version" {
  description = "Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name to be imported"
  type        = string
}

variable "agents_availability_zones" {
  type        = list(string)
  description = "A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
}

variable "sysagents_max_count" {
  description = "Maximum number of nodes in a pool"
  type        = number
}

variable "sysagents_max_pods" {
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
}

variable "sysagents_min_count" {
  description = "Minimum number of nodes in a pool"
  type        = number
}

variable "sysagents_pool_name" {
  description = "The default Azure AKS agentpool (nodepool) name."
  type        = string
}

variable "agents_type" {
  description = "The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets."
  type        = string
}

variable "azure_policy_enabled" {
  description = "Enable Azure Policy Addon."
  type        = bool
}

variable "enable_auto_scaling" {
  description = "Enable node pool autoscaling"
  type        = bool
}

variable "enable_host_encryption" {
  description = "Enable Host Encryption for default node pool. Encryption at host feature must be enabled on the subscription: https://docs.microsoft.com/azure/virtual-machines/linux/disks-enable-host-based-encryption-cli"
  type        = bool
}

variable "http_application_routing_enabled" {
  description = "Enable HTTP Application Routing Addon (forces recreation)."
  type        = bool
}

variable "log_analytics_workspace_enabled" {
  description = "Enable the integration of azurerm_log_analytics_workspace and azurerm_log_analytics_solution: https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-onboard"
  type        = bool
}

variable "role_based_access_control_enabled" {
  description = "Enable Role Based Access Control."
  type        = bool
}

variable "local_account_disabled" {
  description = "If `true` local accounts will be disabled. Defaults to `false`. See [the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts) for more information."
  type        = bool
}

variable "net_profile_dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
  type        = string
}

variable "net_profile_docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
  type        = string
}

variable "net_profile_service_cidr" {
  description = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
  type        = string
}

variable "network_plugin" {
  description = "Network plugin to use for networking."
  type        = string
}

variable "network_policy" {
  description = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created."
  type        = string
}

variable "sysagents_os_disk_size_gb" {
  description = "Disk size of system node pool nodes in GBs."
  type        = number
}

variable "private_cluster_enabled" {
  description = "If true cluster API server will be exposed only on internal IP address and available only in cluster vnet."
  type        = bool
}

variable "rbac_aad_managed" {
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  type        = bool
}

variable "sku_tier" {
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid"
  type        = string
}

variable "vnet_subnet_name" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "open_service_mesh_enabled" {
  description = "Is Open Service Mesh enabled? For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about)."
  type        = bool
}

variable "rbac_aad_admin_group_object_ids" {
  description = "Object ID of groups with admin access."
  type        = list(string)
}

variable "identity_type" {
  description = "The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well."
  type        = string
}

variable "ingress_application_gateway_enabled" {
  description = "Whether to deploy the Application Gateway ingress controller to this Kubernetes Cluster?"
  type        = bool
}

variable "usernodepool" {
  type = list(object({
    usernodepool_name          = string      # "The default Azure AKS agentpool (nodepool) name."
    useragents_min_count       = number      # "Minimum number of nodes in a pool"
    useragents_max_count       = number      # "Maximum number of nodes in a pool"
    useragents_max_pods        = number      # "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
    useragents_vm_size         = string      # "The Usernode pool VM T-Shirt size"
    useragents_os_disk_size_gb = number      #"Disk size of User node pool nodes in GBs."
    useragents_labels          = map(string) # Usernode pool labels
  }))
}

variable "key_vault_secrets_provider_enabled" {
  type        = bool
  description = "Whether to use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster."
}

variable "acr_name" {
  type        = string
  description = "Container registry name"
}

variable "acr_resource_group_name" {
  type        = string
  description = "Container registry resource group name"
}

variable "akv_name" {
  type        = string
  description = "Key vault name"
}

variable "akv_resource_group_name" {
  type        = string
  description = "Key vault resource group name"
}

variable "arm_client_id" {
  type        = string
  description = "Hub client ID"
}

variable "arm_client_secret" {
  type        = string
  description = "Hub client Secret"
}

variable "arm_subscription_id" {
  type        = string
  description = "Hub subscription ID"
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "location" {
  type        = string
  description = "The location of resources"
}

variable "secret_rotation_enabled" {
  type        = bool
  description = "Is secret rotation enabled? This variable is only used when `key_vault_secrets_provider_enabled` is `true` and defaults to `false`"
  default     = false
}

variable "secret_rotation_interval" {
  type        = string
  description = "The interval to poll for secret rotation. This attribute is only set when `secret_rotation` is `true` and defaults to `2m`"
  default     = "2m"
}

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "action_group" {
  type        = string
  description = "Name of action group that should be triggered in case of any alert"
}

variable "deployments" {
  type        = list(string)
  description = "List of services deployed in AKS"
}

variable "deployment_alerts" {
  description = "List of log based alerts for deployment"
  type = list(object({
    name                    = string,
    evaluation_frequency    = string,
    target_group            = list(string),
    severity                = number,
    window_duration         = string,
    description             = string,
    operator                = string,
    query                   = string,
    threshold               = number,
    time_aggregation_method = string,
    metric_measure_column   = string
  }))
}

variable "hpa_alert_enabled" {
  type        = bool
  description = "true if hpa based alerts need to be enabled"
  default     = true
}

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "(Optional) The IP ranges to allow for incoming traffic to the server nodes."
}

variable "ingress_application_gateway_id" {
  type        = string
  description = "The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster."
  default     = null
}

variable "ingress_application_gateway_name" {
  type        = string
  description = "The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
  default     = null
}

variable "ingress_application_gateway_subnet_cidr" {
  type        = string
  description = "The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
  default     = null
}

variable "ingress_application_gateway_subnet_id" {
  type        = string
  description = "The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
  default     = null
}

variable "persistent_sa_role_required" {
  type        = bool
  description = "true if Contributor role is required on persistent Storage Account"
  default     = false
}

variable "app_action_group" {
  type        = string
  description = "Name of application action group"
  default     = null
}

variable "required_preview_features" {
  type        = list(string)
  description = "List of Microsoft.ContainerService features to be registered"
}