<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.19.1 |
| <a name="provider_azurerm.site_spoke"></a> [azurerm.site\_spoke](#provider\_azurerm.site\_spoke) | 3.19.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.this1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.this2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_forwarded_traffic"></a> [allow\_forwarded\_traffic](#input\_allow\_forwarded\_traffic) | description | `string` | `false` | no |
| <a name="input_allow_gateway_transit"></a> [allow\_gateway\_transit](#input\_allow\_gateway\_transit) | description | `string` | `false` | no |
| <a name="input_allow_virtual_network_access"></a> [allow\_virtual\_network\_access](#input\_allow\_virtual\_network\_access) | description | `bool` | `false` | no |
| <a name="input_arm_client_id"></a> [arm\_client\_id](#input\_arm\_client\_id) | Hub client ID | `string` | n/a | yes |
| <a name="input_arm_client_secret"></a> [arm\_client\_secret](#input\_arm\_client\_secret) | Hub client Secret | `string` | n/a | yes |
| <a name="input_arm_subscription_id"></a> [arm\_subscription\_id](#input\_arm\_subscription\_id) | Hub subscription ID | `string` | n/a | yes |
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | `"oss"` | no |
| <a name="input_hub_peer_name"></a> [hub\_peer\_name](#input\_hub\_peer\_name) | Name of the VNET peering between HUB and <ENV> | `string` | n/a | yes |
| <a name="input_hub_resource_group"></a> [hub\_resource\_group](#input\_hub\_resource\_group) | Resource group name for HUB VNet | `string` | n/a | yes |
| <a name="input_hub_vnet_name"></a> [hub\_vnet\_name](#input\_hub\_vnet\_name) | HUB VNet resource name | `string` | n/a | yes |
| <a name="input_spoke_peer_name"></a> [spoke\_peer\_name](#input\_spoke\_peer\_name) | Name of the VNET peering between <ENV> and HUB | `string` | n/a | yes |
| <a name="input_spoke_resource_group"></a> [spoke\_resource\_group](#input\_spoke\_resource\_group) | Resource group name for <ENV> VNet | `string` | n/a | yes |
| <a name="input_spoke_vnet_name"></a> [spoke\_vnet\_name](#input\_spoke\_vnet\_name) | The <ENV> VNet resource name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->