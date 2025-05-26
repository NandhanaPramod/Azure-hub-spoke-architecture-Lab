<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_notification_hub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_mode"></a> [application\_mode](#input\_application\_mode) | The Application Mode which defines which server the APNS Messages should be sent to. Possible values are Production and Sandbox. | `string` | n/a | yes |
| <a name="input_basename"></a> [basename](#input\_basename) | Prefix used for all resources names | `string` | n/a | yes |
| <a name="input_bundle_id"></a> [bundle\_id](#input\_bundle\_id) | The Bundle ID of the iOS/macOS application to send push notifications for, such as com.hashicorp.example. | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Common tags for resources | `map(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Prefix used for environment name | `string` | n/a | yes |
| <a name="input_google_api_key"></a> [google\_api\_key](#input\_google\_api\_key) | Push notification Google api key | `string` | n/a | yes |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | The Apple Push Notifications Service (APNS) Key. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location where Notification Hub will be running on | `string` | n/a | yes |
| <a name="input_team_id"></a> [team\_id](#input\_team\_id) | The ID of the team the Token. | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | The Push Token associated with the Apple Developer Account. This is the contents of the key downloaded from the Apple Developer Portal between the -----BEGIN PRIVATE KEY----- and -----END PRIVATE KEY----- blocks. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->