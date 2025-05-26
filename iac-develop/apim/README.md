<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_logger.logger](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_logger) | resource |
| [azurerm_api_management_named_value.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_policy.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_policy) | resource |
| [azurerm_api_management_product.product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product) | resource |
| [azurerm_api_management_product_policy.product_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_policy) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | n/a | `string` | n/a | yes |
| <a name="input_apim_product"></a> [apim\_product](#input\_apim\_product) | n/a | <pre>list(object({<br>    product_id             = string<br>    display_name           = string<br>    subscriptions_limit    = string<br>    subscription_required  = bool<br>    approval_required      = bool<br>    published              = bool<br>    product_policy_content = string<br>  }))</pre> | n/a | yes |
| <a name="input_backwards_compatible"></a> [backwards\_compatible](#input\_backwards\_compatible) | This component should be created in <basename>\_<tf\_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs. | `bool` | `false` | no |
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | `"oss"` | no |
| <a name="input_businessowner"></a> [businessowner](#input\_businessowner) | Environment owner (it/business unit/etc) | `any` | n/a | yes |
| <a name="input_client"></a> [client](#input\_client) | Name of client | `any` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Prefix used for environment type (hub/dev/qa/pp/prod) | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of resources | `any` | n/a | yes |
| <a name="input_managed_by_terraform"></a> [managed\_by\_terraform](#input\_managed\_by\_terraform) | Managed Resource by Terraform | `string` | `"This resource is managed by terraform, do not make any changes direct to the console as they will be removed and or lost"` | no |
| <a name="input_named_values"></a> [named\_values](#input\_named\_values) | Map of named values to be added to APIM | `map(string)` | n/a | yes |
| <a name="input_needsSubscription"></a> [needsSubscription](#input\_needsSubscription) | Is API Key needed to invoke the API ? | `bool` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of project | `any` | n/a | yes |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | api management publisher email | `string` | n/a | yes |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | api management publisher name | `string` | n/a | yes |
| <a name="input_ratelimit"></a> [ratelimit](#input\_ratelimit) | Maximum number call rate limit per key | `string` | n/a | yes |
| <a name="input_ratelimitrenewal"></a> [ratelimitrenewal](#input\_ratelimitrenewal) | Renewal time interval in seconds for the call rate limit per key | `string` | n/a | yes |
| <a name="input_serviceclass"></a> [serviceclass](#input\_serviceclass) | Environment classification (non-prod/prod) | `any` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | api management sku | `string` | `"Developer_1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | api management resource tags | `map` | <pre>{<br>  "Data_Classification": "Standard"<br>}</pre> | no |
| <a name="input_virtual_network_type"></a> [virtual\_network\_type](#input\_virtual\_network\_type) | api management virtual network type | `string` | `"Internal"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->