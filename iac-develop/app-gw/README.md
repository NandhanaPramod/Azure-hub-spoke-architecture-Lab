<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app-gateway-non-prod"></a> [app-gateway-non-prod](#module\_app-gateway-non-prod) | ./modules/app-gateway/ | n/a |
| <a name="module_app-gateway-prodv1"></a> [app-gateway-prodv1](#module\_app-gateway-prodv1) | ./modules/app-gateway/ | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.prod_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_role_assignment.prodv1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.sp_to_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.prodv1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.uai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.uat2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.uat3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.gw_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_web_application_firewall_policy.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/web_application_firewall_policy) | data source |
| [azurerm_web_application_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/web_application_firewall_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alerts"></a> [alerts](#input\_alerts) | List of log based alerts configured for application gateway | <pre>list(object({<br>    name                    = string,<br>    evaluation_frequency    = string,<br>    severity                = number,<br>    window_duration         = string,<br>    description             = string,<br>    operator                = string,<br>    query                   = string,<br>    threshold               = number,<br>    time_aggregation_method = string<br>  }))</pre> | n/a | yes |
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | `"oss"` | no |
| <a name="input_basename_v1"></a> [basename\_v1](#input\_basename\_v1) | Prefix used for all resources names | `string` | `"iskan"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Common tags for resources | `map(string)` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Prefix used for environment name | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | description | `string` | `""` | no |
| <a name="input_non_prod_action_group"></a> [non\_prod\_action\_group](#input\_non\_prod\_action\_group) | Action group for Non-prod alerts | `string` | n/a | yes |
| <a name="input_prod_action_group"></a> [prod\_action\_group](#input\_prod\_action\_group) | Action group for Pprod alerts | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | Availability zones for the APP GW and PublicIp | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
