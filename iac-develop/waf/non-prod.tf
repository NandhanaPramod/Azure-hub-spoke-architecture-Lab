# ## Non-Prod
resource "azurerm_web_application_firewall_policy" "waf_nonprod" {
  name                = join("-", [var.basename, "waf", "nonprod"])
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 1000
  }

  custom_rules {
    name      = "thirdPartyWhitelist"
    priority  = 5
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RequestHeaders"
        selector      = "X-Forwarded-For"
      }

      operator           = "BeginsWith"
      negation_condition = true
      match_values = [
        "10.253",
        "10.95",
        "10.92",
        "192.168.19",
        "80.227.101.131",
        "10.201",
        "10.244.1.157",
        "10.244.1.156",
        "20.74.248.246",
        "20.74.249.168"
      ]
    }

    match_conditions {
      match_variables {
        variable_name = "RequestUri"
      }

      operator           = "Regex"
      negation_condition = false
      match_values       = ["^/(pc|fab|dmt|teyaseer|adsg|addc|api/cba/(adpf|camunda|graphql|events)|gis/webhook|cba/webhook)(.*)"]
    }

    action = "Block"
  }
  
  custom_rules {
    name      = "gitLabRunnersWhitelist"
    priority  = 1
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RequestHeaders"
        selector      = "X-Forwarded-For"
      }

      operator           = "BeginsWith"
      negation_condition = false
      match_values = [
        "20.216.60.157"
      ]
    }

    match_conditions {
      match_variables {
        variable_name = "RequestUri"
      }

      operator           = "Regex"
      negation_condition = false
      match_values       = ["^/(pc|fab|dmt|teyaseer|adsg|addc|api/cba|gis/webhook|cba/webhook|graphql/schema)(.*)"]
    }

    action = "Allow"
  }

  custom_rules {
    name      = "internalAPIs"
    priority  = 15
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RequestUri"
      }

      operator           = "Regex"
      negation_condition = false
      match_values       = ["^/(adha/send_sms|gis/bulk_reserve_property|graphql/schema)(.*)", "^/outbound(/)?"]
    }

    match_conditions {
      match_variables {
        variable_name = "RequestHeaders"
        selector      = "X-Forwarded-For"
      }

      operator           = "BeginsWith"
      negation_condition = true
      match_values = [
        "10.95",
        "10.92",
        "192.168.19",
        "80.227.101.131",
        "10.201.13",
        "10.201.12"
      ]
    }

    action = "Block"
  }

  custom_rules {
    action    = "Allow"
    name      = "camundaWhitelist"
    priority  = 20
    rule_type = "MatchRule"

    match_conditions {
      match_values = [
        "^/(tasklist/graphql|auth/admin/realms|auth/realms/camunda-platform/protocol/openid-connect/(auth|token|login-status-iframe.html/init))"
      ]
      negation_condition = false
      operator           = "Regex"
      transforms = [
        "Lowercase",
      ]

      match_variables {
        variable_name = "RequestUri"
      }
    }
    match_conditions {
      match_values = [
        "camunda(-)?.*\\.adha\\.gov\\.ae",
      ]
      negation_condition = false
      operator           = "Regex"
      transforms = [
        "Lowercase",
      ]

      match_variables {
        selector      = "host"
        variable_name = "RequestHeaders"
      }
    }
    match_conditions {
      match_values = [
        "192.168.19",
        "10.95",
        "10.92",
        "10.94",
        "10.201.13",
        "10.201.12"
      ]
      negation_condition = false
      operator           = "BeginsWith"
      transforms         = []

      match_variables {
        selector      = "X-Forwarded-For"
        variable_name = "RequestHeaders"
      }
    }
  }

  custom_rules {
    name      = "PSGlobalSecurity"
    priority  = 4
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RequestHeaders"
        selector      = "X-Forwarded-For"
      }

      operator           = "BeginsWith"
      match_values = [
        "14.140.116.145",
        "167.246.40.120",
        "208.118.237.161"
      ]
    }

    action = "Allow"
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
      rule_group_override {
        rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
        disabled_rules = [
          "942150",
          "942190",
          "942200",
          "942370",
          "942410",
          "942430",
        ]
      }
      rule_group_override {
        rule_group_name = "REQUEST-932-APPLICATION-ATTACK-RCE"
        disabled_rules = [
          "932110",
          "932115"
        ]
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "post_logout_redirect_uri"
      selector_match_operator = "Equals"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
          excluded_rules  = ["931130"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "input"
      selector_match_operator = "Equals"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
          excluded_rules  = ["942260"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "query"
      selector_match_operator = "Equals"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
          excluded_rules  = ["942340", "942260"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "variables"
      selector_match_operator = "Contains"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
          excluded_rules  = ["942340", "942260"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "deviceDetail"
      selector_match_operator = "Contains"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
          excluded_rules  = ["942260", "942340"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "questions"
      selector_match_operator = "Contains"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
          excluded_rules  = ["942390"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "response"
      selector_match_operator = "Contains"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
          excluded_rules  = ["942260", "942340"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "deviceDetail"
      selector_match_operator = "Contains"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "General"
          excluded_rules  = ["200002", "200003"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "response"
      selector_match_operator = "Contains"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "General"
          excluded_rules  = ["200002", "200003"]
        }
      }
    }
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "request"
      selector_match_operator = "Contains"
      excluded_rule_set {
        version = 3.2
        rule_group {
          rule_group_name = "General"
          excluded_rules  = ["200002", "200003"]
        }
      }
    }
  }

  tags = {
    ProjectName  = upper("${var.basename}-${var.client}")
    Environment  = upper("${var.environment}")
    Location     = lower("${var.location}")
    BusinessUnit = upper("${var.businessowner}")
    ServiceClass = lower("${var.serviceclass}")
  }
}
