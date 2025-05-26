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
| <a name="provider_azurerm.hub"></a> [azurerm.hub](#provider\_azurerm.hub) | 3.19.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_client_config.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_network_ddos_protection_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_ddos_protection_plan) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arm_client_id"></a> [arm\_client\_id](#input\_arm\_client\_id) | Hub client ID | `string` | n/a | yes |
| <a name="input_arm_client_secret"></a> [arm\_client\_secret](#input\_arm\_client\_secret) | Hub client Secret | `string` | n/a | yes |
| <a name="input_arm_subscription_id"></a> [arm\_subscription\_id](#input\_arm\_subscription\_id) | Hub subscription ID | `string` | n/a | yes |
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | `"oss"` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Create resource group if it's a first use:  <basename>\_<tf\_workspace> | `bool` | `false` | no |
| <a name="input_ddos_name"></a> [ddos\_name](#input\_ddos\_name) | The name of the ddos service | `string` | `"iskan-ddos-protection-plan"` | no |
| <a name="input_ddos_resource_group"></a> [ddos\_resource\_group](#input\_ddos\_resource\_group) | The ddos service resource group name | `string` | `"oss_hub"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Common tags for resources | `map(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Prefix used for environment name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of cluster, if not defined it will be read from the resource-group | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | The subnets and their properties | <pre>list(object({<br>    name_prefix            = string<br>    name_postfix           = list(string)<br>    address_prefix         = string<br>    next_hop_type          = string<br>    next_hop_in_ip_address = string<br>  }))</pre> | `[]` | no |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | A list of security group to be created. | <pre>list(object({<br>    name = string<br>    rule = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | A list of security rules to be created. | <pre>list(object({<br>    name                       = string<br>    priority                   = number<br>    direction                  = string<br>    access                     = string<br>    protocol                   = string<br>    source_port_range          = string<br>    destination_port_range     = string<br>    source_address_prefix      = string<br>    destination_address_prefix = string<br>  }))</pre> | n/a | yes |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | The list of Service endpoints to associate with the subnet. | `list(string)` | `[]` | no |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | The cidr block for the vnet | `list(string)` | n/a | yes |
| <a name="input_vnet_subnets"></a> [vnet\_subnets](#input\_vnet\_subnets) | The subnets and their properties | <pre>list(object({<br>    name              = string<br>    address_prefixes  = list(string)<br>    security_group    = string<br>    service_endpoints = list(string)<br>    route_table       = string<br><br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->