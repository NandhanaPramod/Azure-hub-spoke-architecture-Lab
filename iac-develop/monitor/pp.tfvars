basename              = "iskan"
backwards_compatible  = false
create_resource_group = true

log_analytics_sku               = "PerGB2018"
log_analytics_retention_in_days = 30
log_analytics_daily_quota_gb    = -1
app_insights_retention_in_days  = 30
action_groups = [{
  name           = "infra-alerts"
  email_adresses = ["MENA-ADHA-Non-Prod-Ops-Team_PBS_TEAM_IND@groups.publicisgroupe.net","adfsupportadhanp@adfolks.com"]
}]
