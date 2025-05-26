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
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/application_insights) | resource |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_insights_retention_in_days"></a> [app\_insights\_retention\_in\_days](#input\_app\_insights\_retention\_in\_days) | Specifies the retention period in days for App Insights | `number` | n/a | yes |
| <a name="input_backwards_compatible"></a> [backwards\_compatible](#input\_backwards\_compatible) | This component should be created in <basename>\_<tf\_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs. | `bool` | `false` | no |
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | `"oss"` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Create resource group if it's a first use:  <basename>\_<tf\_workspace> | `bool` | `false` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Common tags for resources | `map(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Region name where resources will be created | `string` | n/a | yes |
| <a name="input_log_analytics_daily_quota_gb"></a> [log\_analytics\_daily\_quota\_gb](#input\_log\_analytics\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB | `number` | n/a | yes |
| <a name="input_log_analytics_retention_in_days"></a> [log\_analytics\_retention\_in\_days](#input\_log\_analytics\_retention\_in\_days) | The workspace data retention in days | `number` | n/a | yes |
| <a name="input_log_analytics_sku"></a> [log\_analytics\_sku](#input\_log\_analytics\_sku) | Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->