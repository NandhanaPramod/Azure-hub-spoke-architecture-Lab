<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_security_center_auto_provisioning.auto-provisioning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_auto_provisioning) | resource |
| [azurerm_security_center_automation.la-exports](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_automation) | resource |
| [azurerm_security_center_contact.mdc_contact](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact) | resource |
| [azurerm_security_center_setting.setting_mcas](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_setting) | resource |
| [azurerm_security_center_setting.setting_mde](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_setting) | resource |
| [azurerm_security_center_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_workspace) | resource |
| [azurerm_subscription_policy_assignment.asb_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_assignment.va-auto-provisioning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Common tags for resources. | `map(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name i.e. hub/dev/qa/pp/prod | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name where DDoS protection plan will be deployed | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->