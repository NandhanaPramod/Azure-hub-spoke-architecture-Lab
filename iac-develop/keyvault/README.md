<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.16.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/key_vault) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/role_assignment) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_azure_services_bypass_firewall"></a> [allow\_azure\_services\_bypass\_firewall](#input\_allow\_azure\_services\_bypass\_firewall) | Specifies which traffic can bypass the network rules | `bool` | n/a | yes |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault | `list(string)` | n/a | yes |
| <a name="input_backwards_compatible"></a> [backwards\_compatible](#input\_backwards\_compatible) | This component should be created in <basename>\_<tf\_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs. | `bool` | `false` | no |
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | `"oss"` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | This component should be created in <basename>\_<tf\_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs. | `bool` | `false` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | The Default Action to use when no rules match. Possible values are Allow and Deny | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Enable RBAC access to KV | `bool` | `true` | no |
| <a name="input_key_vault_admin"></a> [key\_vault\_admin](#input\_key\_vault\_admin) | The admin user OBJECT\_ID for the KV. Defaults to `sa_terraform@adhaauh.onmicrosoft.com` object id | `string` | `"2ec87220-2efc-46e0-9d5f-545cff9b07a4"` | no |
| <a name="input_keyvault_sku"></a> [keyvault\_sku](#input\_keyvault\_sku) | The Name of the SKU used for this Key Vault | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Region name where resources will be created | `string` | n/a | yes |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Enable purge protection for kv. | `bool` | `false` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted | `number` | n/a | yes |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | List of subnet names from which traffic should be allowed | `list(string)` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | VNet name from which traffic should be allowed | `string` | n/a | yes |
| <a name="input_virtual_network_resource_group"></a> [virtual\_network\_resource\_group](#input\_virtual\_network\_resource\_group) | The name of the resource group the Virtual Network is located in | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->