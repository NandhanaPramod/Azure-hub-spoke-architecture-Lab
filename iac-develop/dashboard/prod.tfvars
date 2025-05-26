basename = "iskan"
spoke_dashboards = [{
  name                  = "ProdDashboard"
  dashboard_config_file = "spoke.tpl"
  aks_name              = "iskan-prod-aks"
  aks_namespace         = "default"
},
{
  name                  = "ProdDashboardDHP"
  dashboard_config_file = "spoke.tpl"
  aks_name              = "iskan-prod-cba-aks"
  aks_namespace         = "cba"
}]