backwards_compatible  = true
create_resource_group = true

log_analytics_sku               = "PerGB2018"
log_analytics_retention_in_days = 30
log_analytics_daily_quota_gb    = -1
app_insights_retention_in_days  = 30
action_groups = [{
  name           = "prod-alerts"
  email_adresses = ["MENA_ADHA_Ops_Team@publicissapient.com", "it-ops@adha.gov.ae", "adfsupportadha@adfolks.com"]
  },
  {
    name           = "infra-alerts"
    email_adresses = ["MENA-ADHA-Non-Prod-Ops-Team_PBS_TEAM_IND@groups.publicisgroupe.net"]
},
{
  name           = "app-alerts"
  email_adresses = ["applications@adha.gov.ae" , "ossappsupport@publicissapient.com"]
}]
