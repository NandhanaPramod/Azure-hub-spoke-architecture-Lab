<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.59.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.18.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mssql-server"></a> [mssql-server](#module\_mssql-server) | kumarvna/mssql-db/azurerm | 1.3.0 |

## Resources

| Name | Type |
|------|------|
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | `"oss"` | no |
| <a name="input_env"></a> [env](#input\_env) | Prefix used for environment name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of cluster, if not defined it will be read from the resource-group | `string` | n/a | yes |
| <a name="input_mmsql_enable_firewall_rules"></a> [mmsql\_enable\_firewall\_rules](#input\_mmsql\_enable\_firewall\_rules) | Enable firewall rules | `bool` | `true` | no |
| <a name="input_mssql_admin_password"></a> [mssql\_admin\_password](#input\_mssql\_admin\_password) | Admin username password | `string` | `null` | no |
| <a name="input_mssql_admin_username"></a> [mssql\_admin\_username](#input\_mssql\_admin\_username) | description | `string` | `"ossdevsqladmin"` | no |
| <a name="input_mssql_email_addresses_for_alerts"></a> [mssql\_email\_addresses\_for\_alerts](#input\_mssql\_email\_addresses\_for\_alerts) | Email addresses for alerts | `list(string)` | <pre>[<br>  "ryan.loots@publicssapient.com",<br>  "euglupul@publicisgroupe.net",<br>  "sourabh.sharma@publicissapient.com"<br>]</pre> | no |
| <a name="input_mssql_enable_log_monitoring"></a> [mssql\_enable\_log\_monitoring](#input\_mssql\_enable\_log\_monitoring) | Enable log monitor | `bool` | `true` | no |
| <a name="input_mssql_enable_private_endpoint"></a> [mssql\_enable\_private\_endpoint](#input\_mssql\_enable\_private\_endpoint) | Enable private endpoint | `bool` | `true` | no |
| <a name="input_mssql_enable_threat_detection_policy"></a> [mssql\_enable\_threat\_detection\_policy](#input\_mssql\_enable\_threat\_detection\_policy) | Enable Thread detection policy | `bool` | `true` | no |
| <a name="input_mssql_enable_vulnerability_assessment"></a> [mssql\_enable\_vulnerability\_assessment](#input\_mssql\_enable\_vulnerability\_assessment) | Enable vulnerability assessment | `bool` | `false` | no |
| <a name="input_mssql_firewall_rules"></a> [mssql\_firewall\_rules](#input\_mssql\_firewall\_rules) | Firewall rules to be added in case they are enabled | <pre>list(object({<br>    name             = string<br>    start_ip_address = string<br>    end_ip_address   = string<br>  }))</pre> | `null` | no |
| <a name="input_mssql_sql_database_edition"></a> [mssql\_sql\_database\_edition](#input\_mssql\_sql\_database\_edition) | Sql database edition | `string` | `"Standard"` | no |
| <a name="input_mssql_sqldb_service_objective_name"></a> [mssql\_sqldb\_service\_objective\_name](#input\_mssql\_sqldb\_service\_objective\_name) | Mssql database service objective name | `string` | `"S1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_sql_server_fqdn"></a> [primary\_sql\_server\_fqdn](#output\_primary\_sql\_server\_fqdn) | The fully qualified domain name of the primary Azure SQL Server |
| <a name="output_primary_sql_server_id"></a> [primary\_sql\_server\_id](#output\_primary\_sql\_server\_id) | The primary Microsoft SQL Server ID |
| <a name="output_primary_sql_server_private_endpoint"></a> [primary\_sql\_server\_private\_endpoint](#output\_primary\_sql\_server\_private\_endpoint) | id of the Primary SQL server Private Endpoint |
| <a name="output_primary_sql_server_private_endpoint_fqdn"></a> [primary\_sql\_server\_private\_endpoint\_fqdn](#output\_primary\_sql\_server\_private\_endpoint\_fqdn) | Priamary SQL server private endpoint IPv4 Addresses |
| <a name="output_primary_sql_server_private_endpoint_ip"></a> [primary\_sql\_server\_private\_endpoint\_ip](#output\_primary\_sql\_server\_private\_endpoint\_ip) | Priamary SQL server private endpoint IPv4 Addresses |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | The location of the resource group in which resources are created |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group in which resources are created |
| <a name="output_sql_database_id"></a> [sql\_database\_id](#output\_sql\_database\_id) | The SQL Database ID |
| <a name="output_sql_database_name"></a> [sql\_database\_name](#output\_sql\_database\_name) | The SQL Database Name |
| <a name="output_sql_server_admin_password"></a> [sql\_server\_admin\_password](#output\_sql\_server\_admin\_password) | SQL database administrator login password |
| <a name="output_sql_server_admin_user"></a> [sql\_server\_admin\_user](#output\_sql\_server\_admin\_user) | SQL database administrator login id |
| <a name="output_sql_server_private_dns_zone_domain"></a> [sql\_server\_private\_dns\_zone\_domain](#output\_sql\_server\_private\_dns\_zone\_domain) | DNS zone name of SQL server Private endpoints dns name records |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account |
<!-- END_TF_DOCS -->