basename = "oss"
spoke_dashboards = [
  {
    name                  = "DevDashboard"
    dashboard_config_file = "spoke.tpl"
    aks_name              = "oss-dev-aks"
    aks_namespace         = "default"
  },
  {
    name                  = "DevDashboardDHP"
    dashboard_config_file = "spoke.tpl"
    aks_name              = "oss-dev-aks"
    aks_namespace         = "cba"
  }
]