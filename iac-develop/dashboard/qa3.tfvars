basename = "iskan"
spoke_dashboards = [
  {
    name                  = "QA3Dashboard"
    dashboard_config_file = "spoke.tpl"
    aks_name              = "iskan-qa3-aks"
    aks_namespace         = "default"
  },
  {
    name                  = "QA3DashboardDHP"
    dashboard_config_file = "spoke.tpl"
    aks_name              = "iskan-qa3-aks"
    aks_namespace         = "cba"
  }
]
