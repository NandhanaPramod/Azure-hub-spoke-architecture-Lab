<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.11 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | 3.17.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.49.0 |
| <a name="provider_azurerm.hub"></a> [azurerm.hub](#provider\_azurerm.hub) | 3.49.0 |
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | 3.17.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.6.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | git::https://github.com/Azure/terraform-azurerm-aks.git | 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster_node_pool.usernodepool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_metric_alert.aks_cluster_autoscale_health_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.aks_cluster_disk_usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.aks_cluster_memory_usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.aks_cluster_unneeded_nodes](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.nodepool_cpu_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.nodepool_mem_rss_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.nodepool_mem_working_set_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.hpa_autoscale_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.node_autoscale_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_resource_provider_registration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration) | resource |
| [azurerm_role_assignment.aks_to_acr_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_to_identity_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_to_keyvault_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_to_persistent_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_to_static_content_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_to_subnet_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_to_vmms_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.identity_to_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.identity_to_nodes](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [gitlab_group_variable.this](https://registry.terraform.io/providers/gitlabhq/gitlab/3.17.0/docs/resources/group_variable) | resource |
| [helm_release.identity](https://registry.terraform.io/providers/hashicorp/helm/2.6.0/docs/resources/release) | resource |
| [null_resource.enable_keda](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.enable_osm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_registry.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Container registry name | `string` | n/a | yes |
| <a name="input_acr_resource_group_name"></a> [acr\_resource\_group\_name](#input\_acr\_resource\_group\_name) | Container registry resource group name | `string` | n/a | yes |
| <a name="input_action_group"></a> [action\_group](#input\_action\_group) | Name of action group that should be triggered in case of any alert | `string` | n/a | yes |
| <a name="input_agents_availability_zones"></a> [agents\_availability\_zones](#input\_agents\_availability\_zones) | A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created. | `list(string)` | n/a | yes |
| <a name="input_agents_type"></a> [agents\_type](#input\_agents\_type) | The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets. | `string` | n/a | yes |
| <a name="input_akv_name"></a> [akv\_name](#input\_akv\_name) | Key vault name | `string` | n/a | yes |
| <a name="input_akv_resource_group_name"></a> [akv\_resource\_group\_name](#input\_akv\_resource\_group\_name) | Key vault resource group name | `string` | n/a | yes |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | (Optional) The IP ranges to allow for incoming traffic to the server nodes. | `set(string)` | n/a | yes |
| <a name="input_arm_client_id"></a> [arm\_client\_id](#input\_arm\_client\_id) | Hub client ID | `string` | n/a | yes |
| <a name="input_arm_client_secret"></a> [arm\_client\_secret](#input\_arm\_client\_secret) | Hub client Secret | `string` | n/a | yes |
| <a name="input_arm_subscription_id"></a> [arm\_subscription\_id](#input\_arm\_subscription\_id) | Hub subscription ID | `string` | n/a | yes |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | Enable Azure Policy Addon. | `bool` | n/a | yes |
| <a name="input_backwards_compatible"></a> [backwards\_compatible](#input\_backwards\_compatible) | This component should be created in <basename>\_<tf\_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs. | `bool` | `false` | no |
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | `"oss"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Common tags for resources | `map(string)` | n/a | yes |
| <a name="input_deployment_alerts"></a> [deployment\_alerts](#input\_deployment\_alerts) | List of log based alerts for deployment | <pre>list(object({<br>    name                    = string,<br>    evaluation_frequency    = string,<br>    severity                = number,<br>    window_duration         = string,<br>    description             = string,<br>    operator                = string,<br>    query                   = string,<br>    threshold               = number,<br>    time_aggregation_method = string,<br>    metric_measure_column   = string<br>  }))</pre> | n/a | yes |
| <a name="input_deployments"></a> [deployments](#input\_deployments) | List of services deployed in AKS | `list(string)` | n/a | yes |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Enable node pool autoscaling | `bool` | n/a | yes |
| <a name="input_enable_host_encryption"></a> [enable\_host\_encryption](#input\_enable\_host\_encryption) | Enable Host Encryption for default node pool. Encryption at host feature must be enabled on the subscription: https://docs.microsoft.com/azure/virtual-machines/linux/disks-enable-host-based-encryption-cli | `bool` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Prefix used for environment name | `string` | n/a | yes |
| <a name="input_hpa_alert_enabled"></a> [hpa\_alert\_enabled](#input\_hpa\_alert\_enabled) | true if hpa based alerts need to be enabled | `bool` | `true` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | Enable HTTP Application Routing Addon (forces recreation). | `bool` | n/a | yes |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well. | `string` | n/a | yes |
| <a name="input_ingress_application_gateway_enabled"></a> [ingress\_application\_gateway\_enabled](#input\_ingress\_application\_gateway\_enabled) | Whether to deploy the Application Gateway ingress controller to this Kubernetes Cluster? | `bool` | n/a | yes |
| <a name="input_ingress_application_gateway_id"></a> [ingress\_application\_gateway\_id](#input\_ingress\_application\_gateway\_id) | The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_ingress_application_gateway_name"></a> [ingress\_application\_gateway\_name](#input\_ingress\_application\_gateway\_name) | The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_ingress_application_gateway_subnet_cidr"></a> [ingress\_application\_gateway\_subnet\_cidr](#input\_ingress\_application\_gateway\_subnet\_cidr) | The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_ingress_application_gateway_subnet_id"></a> [ingress\_application\_gateway\_subnet\_id](#input\_ingress\_application\_gateway\_subnet\_id) | The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_key_vault_secrets_provider_enabled"></a> [key\_vault\_secrets\_provider\_enabled](#input\_key\_vault\_secrets\_provider\_enabled) | Whether to use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster. | `bool` | n/a | yes |
| <a name="input_kubernetes_agent_version"></a> [kubernetes\_agent\_version](#input\_kubernetes\_agent\_version) | Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region | `string` | n/a | yes |
| <a name="input_kubernetes_master_version"></a> [kubernetes\_master\_version](#input\_kubernetes\_master\_version) | Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region | `string` | n/a | yes |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | If `true` local accounts will be disabled. Defaults to `false`. See [the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts) for more information. | `bool` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of resources | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_enabled"></a> [log\_analytics\_workspace\_enabled](#input\_log\_analytics\_workspace\_enabled) | Enable the integration of azurerm\_log\_analytics\_workspace and azurerm\_log\_analytics\_solution: https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-onboard | `bool` | n/a | yes |
| <a name="input_net_profile_dns_service_ip"></a> [net\_profile\_dns\_service\_ip](#input\_net\_profile\_dns\_service\_ip) | IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_net_profile_docker_bridge_cidr"></a> [net\_profile\_docker\_bridge\_cidr](#input\_net\_profile\_docker\_bridge\_cidr) | IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_net_profile_service_cidr"></a> [net\_profile\_service\_cidr](#input\_net\_profile\_service\_cidr) | The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for networking. | `string` | n/a | yes |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | Is Open Service Mesh enabled? For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about). | `bool` | n/a | yes |
| <a name="input_persistent_sa_role_required"></a> [persistent\_sa\_role\_required](#input\_persistent\_sa\_role\_required) | true if Contributor role is required on persistent Storage Account | `bool` | `false` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | If true cluster API server will be exposed only on internal IP address and available only in cluster vnet. | `bool` | n/a | yes |
| <a name="input_rbac_aad_admin_group_object_ids"></a> [rbac\_aad\_admin\_group\_object\_ids](#input\_rbac\_aad\_admin\_group\_object\_ids) | Object ID of groups with admin access. | `list(string)` | n/a | yes |
| <a name="input_rbac_aad_managed"></a> [rbac\_aad\_managed](#input\_rbac\_aad\_managed) | Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration. | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to be imported | `string` | n/a | yes |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | Enable Role Based Access Control. | `bool` | n/a | yes |
| <a name="input_secret_rotation_enabled"></a> [secret\_rotation\_enabled](#input\_secret\_rotation\_enabled) | Is secret rotation enabled? This variable is only used when `key_vault_secrets_provider_enabled` is `true` and defaults to `false` | `bool` | `false` | no |
| <a name="input_secret_rotation_interval"></a> [secret\_rotation\_interval](#input\_secret\_rotation\_interval) | The interval to poll for secret rotation. This attribute is only set when `secret_rotation` is `true` and defaults to `2m` | `string` | `"2m"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid | `string` | n/a | yes |
| <a name="input_sysagents_max_count"></a> [sysagents\_max\_count](#input\_sysagents\_max\_count) | Maximum number of nodes in a pool | `number` | n/a | yes |
| <a name="input_sysagents_max_pods"></a> [sysagents\_max\_pods](#input\_sysagents\_max\_pods) | The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `number` | n/a | yes |
| <a name="input_sysagents_min_count"></a> [sysagents\_min\_count](#input\_sysagents\_min\_count) | Minimum number of nodes in a pool | `number` | n/a | yes |
| <a name="input_sysagents_os_disk_size_gb"></a> [sysagents\_os\_disk\_size\_gb](#input\_sysagents\_os\_disk\_size\_gb) | Disk size of system node pool nodes in GBs. | `number` | n/a | yes |
| <a name="input_sysagents_pool_name"></a> [sysagents\_pool\_name](#input\_sysagents\_pool\_name) | The default Azure AKS agentpool (nodepool) name. | `string` | n/a | yes |
| <a name="input_usernodepool"></a> [usernodepool](#input\_usernodepool) | n/a | <pre>list(object({<br>    usernodepool_name          = string      # "The default Azure AKS agentpool (nodepool) name."<br>    useragents_min_count       = number      # "Minimum number of nodes in a pool"<br>    useragents_max_count       = number      # "Maximum number of nodes in a pool"<br>    useragents_max_pods        = number      # "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."<br>    useragents_vm_size         = string      # "The Usernode pool VM T-Shirt size"<br>    useragents_os_disk_size_gb = number      #"Disk size of User node pool nodes in GBs."<br>    useragents_labels          = map(string) # Usernode pool labels<br>  }))</pre> | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the Virtual Network | `string` | n/a | yes |
| <a name="input_vnet_subnet_name"></a> [vnet\_subnet\_name](#input\_vnet\_subnet\_name) | The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->