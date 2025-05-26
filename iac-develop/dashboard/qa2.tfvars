basename = "iskan"
spoke_dashboards = [
  {
    name                  = "QA2Dashboard"
    dashboard_config_file = "spoke.tpl"
    aks_name              = "iskan-qa2-aks"
    aks_namespace         = "default"
  },
  {
    name                  = "QA2DashboardDHP"
    dashboard_config_file = "spoke.tpl"
    aks_name              = "iskan-qa2-aks"
    aks_namespace         = "cba"
  }
]
