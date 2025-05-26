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
| <a name="provider_azurerm.dns_zone"></a> [azurerm.dns\_zone](#provider\_azurerm.dns\_zone) | 3.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/resources/role_assignment) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/client_config) | data source |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.16.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arm_client_id"></a> [arm\_client\_id](#input\_arm\_client\_id) | client ID where DNS zone exists | `string` | n/a | yes |
| <a name="input_arm_client_secret"></a> [arm\_client\_secret](#input\_arm\_client\_secret) | client secret where DNS zone exists | `string` | n/a | yes |
| <a name="input_arm_subscription_id"></a> [arm\_subscription\_id](#input\_arm\_subscription\_id) | subscription ID where DNS zone exists | `string` | n/a | yes |
| <a name="input_basename"></a> [basename](#input\_basename) | Basename of resources | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Common tags for resources | `map(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Region name where resources will be created | `string` | `"uaenorth"` | no |
| <a name="input_private_zones"></a> [private\_zones](#input\_private\_zones) | key value pair of Private DNS zone and its resource group name to be linked with vnet | `map(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the VNet that needs to be linked with private zones | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->