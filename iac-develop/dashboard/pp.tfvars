basename = "iskan"
spoke_dashboards = [{
  name                  = "PreProdDashboard"
  dashboard_config_file = "spoke.tpl"
  aks_name              = "iskan-pp-aks"
  aks_namespace         = "default"
},
{
  name                  = "PreProdDashboardDHP"
  dashboard_config_file = "spoke.tpl"
  aks_name              = "iskan-pp-cba-aks"
  aks_namespace         = "cba"
}
]