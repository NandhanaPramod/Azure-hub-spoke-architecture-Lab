hub_dashboards = [
  {
    name                     = "NonProdApplicationGatewayDashboard"
    dashboard_config_file    = "hub.tpl"
    application_gateway_name = "oss-app-gw-non-prod"
    service_class            = "non-prod"
  },
  {
    name                     = "ProdApplicationGatewayDashboard"
    dashboard_config_file    = "hub.tpl"
    application_gateway_name = "iskan-app-gw"
    service_class            = "prod"
  }
]
basename = "oss"