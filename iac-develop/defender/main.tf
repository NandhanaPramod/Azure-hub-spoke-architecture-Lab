data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_subscription_policy_assignment" "asb_assignment" {
  name                 = "${var.basename}-azure-security-benchmark"
  display_name         = "Azure Security Benchmark"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
  subscription_id      = data.azurerm_subscription.current.id
}

resource "azurerm_security_center_setting" "setting_mcas" {
  setting_name = "MCAS"
  enabled      = true
}

resource "azurerm_security_center_setting" "setting_mde" {
  setting_name = "WDATP"
  enabled      = true
}

resource "azurerm_security_center_contact" "mdc_contact" {
  email               = "euglupul@publicisgroupe.net"
  phone               = "+40723070104"
  alert_notifications = true
  alerts_to_admins    = true
}

resource "azurerm_security_center_auto_provisioning" "auto-provisioning" {
  auto_provision = "On"
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.basename}-mdc-security-la-workspace"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = "PerGB2018"

  tags = local.tags
}

resource "azurerm_security_center_workspace" "this" {
  scope        = data.azurerm_subscription.current.id
  workspace_id = azurerm_log_analytics_workspace.this.id
}

resource "azurerm_subscription_policy_assignment" "va-auto-provisioning" {
  name                 = "${var.basename}-mdc-va-autoprovisioning"
  display_name         = "Configure machines to receive a vulnerability assessment provider"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/13ce0167-8ca6-4048-8e6b-f996402e3c1b"
  subscription_id      = data.azurerm_subscription.current.id
  identity {
    type = "SystemAssigned"
  }
  location   = data.azurerm_resource_group.this.location
  parameters = <<PARAMS
{ "vaType": { "value": "mdeTvm" } }
PARAMS
}

resource "azurerm_role_assignment" "this" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "/subscriptions/14d130e1-6dc9-4742-b681-f29ee8a49472/providers/Microsoft.Authorization/roleDefinitions/fb1c8493-542b-48eb-b624-b4c8fea62acd"
  principal_id       = azurerm_subscription_policy_assignment.va-auto-provisioning.identity[0].principal_id
}

resource "azurerm_security_center_automation" "la-exports" {
  name                = "ExportToWorkspace"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  action {
    type        = "loganalytics"
    resource_id = azurerm_log_analytics_workspace.this.id
  }

  source {
    event_source = "Alerts"
    rule_set {
      rule {
        property_path  = "Severity"
        operator       = "Equals"
        expected_value = "High"
        property_type  = "String"
      }
      rule {
        property_path  = "Severity"
        operator       = "Equals"
        expected_value = "Medium"
        property_type  = "String"
      }
    }
  }

  source {
    event_source = "SecureScores"
  }

  source {
    event_source = "SecureScoreControls"
  }

  scopes = [data.azurerm_subscription.current.id]

  tags = local.tags
}