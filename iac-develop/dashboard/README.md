<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_portal_dashboard.hub_dashboard](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/portal_dashboard) | resource |
| [azurerm_portal_dashboard.spoke_dashboard](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/resources/portal_dashboard) | resource |
| [azurerm_application_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/data-sources/application_gateway) | data source |
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.24.0/docs/data-sources/kubernetes_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_basename"></a> [basename](#input\_basename) | Basename of the resources | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Common tags for resources | `map(string)` | n/a | yes |
| <a name="input_hub_dashboards"></a> [hub\_dashboards](#input\_hub\_dashboards) | List of hub dashboards | <pre>list(object({<br>    name                     = string,<br>    dashboard_config_file    = string,<br>    application_gateway_name = string,<br>    service_class            = string<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Location where dashboard will be created | `string` | n/a | yes |
| <a name="input_spoke_dashboards"></a> [spoke\_dashboards](#input\_spoke\_dashboards) | List of spoke dashboards | <pre>list(object({<br>    name                  = string,<br>    dashboard_config_file = string,<br>    aks_name              = string<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->