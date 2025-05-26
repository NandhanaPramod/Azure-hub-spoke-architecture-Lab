<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_region"></a> [azure\_region](#module\_azure\_region) | claranet/regions/azurerm | v6.0.0 |
| <a name="module_servicebus"></a> [servicebus](#module\_servicebus) | claranet/service-bus/azurerm | v6.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.roleassignment_aks_nodepool_receiver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.roleassignment_aks_nodepool_sender](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.roleassignment_aks_receiver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.roleassignment_aks_sender](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_servicebus_namespace_network_rule_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_network_rule_set) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | n/a | yes |
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | Client name/account used in naming | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Prefix used for environment name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location where your exisiting services are running or you would like to deploy this service bus | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name where the service bus will be deployed/associated with. | `string` | n/a | yes |
| <a name="input_servicebus_namespaces_queues_data"></a> [servicebus\_namespaces\_queues\_data](#input\_servicebus\_namespaces\_queues\_data) | Complete Service bus namespace and Queues data per environment | `any` | n/a | yes |
| <a name="input_servicebus_whitelist_ip"></a> [servicebus\_whitelist\_ip](#input\_servicebus\_whitelist\_ip) | List of IP/CIDR to be whistlisted, to access the service bus. | `list(string)` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project stack name | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID of the respective environment | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->