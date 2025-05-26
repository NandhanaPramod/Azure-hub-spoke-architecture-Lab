basename = "oss"
spoke_dashboards = [
  {
    name                  = "QADashboard"
    dashboard_config_file = "spoke.tpl"
    aks_name              = "oss-qa-aks"
    aks_namespace         = "default"
  },
  {
    name                  = "QADashboardDHP"
    dashboard_config_file = "spoke.tpl"
    aks_name              = "oss-qa-aks"
    aks_namespace         = "cba"
  }
]
