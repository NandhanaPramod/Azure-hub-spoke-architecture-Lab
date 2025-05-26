<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.11 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_web_application_firewall_policy.waf_nonprod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |
| [azurerm_web_application_firewall_policy.waf_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_basename"></a> [basename](#input\_basename) | Name of project | `string` | `"oss"` | no |
| <a name="input_businessowner"></a> [businessowner](#input\_businessowner) | Environment owner (it/business unit/etc) | `string` | `"it"` | no |
| <a name="input_client"></a> [client](#input\_client) | Name of client | `string` | `"adha"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Prefix used for environment type (hub/dev/qa/non-prod/prod) | `string` | `"qa"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of services | `string` | `"uaenorth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to be imported | `string` | `"iskan_firewall"` | no |
| <a name="input_serviceclass"></a> [serviceclass](#input\_serviceclass) | Environment classification (non-prod/prod) | `string` | `"non-prod"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->