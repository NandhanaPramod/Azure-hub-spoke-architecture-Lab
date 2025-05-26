locals {
  app_insights_name                  = "${var.basename}-${terraform.workspace}-app-insights"
  app_insights_name_availability     = "${var.basename}-${terraform.workspace}-3rd-PARTY-DOWN"
  audit_app_insights_name            = "${var.basename}-${terraform.workspace}-audit-app-insights"
  log_analytics_workspace_name       = "${var.basename}-${terraform.workspace}-la-workspace"
  audit_log_analytics_workspace_name = "${var.basename}-${terraform.workspace}-audit-la-workspace"
  monitor_resource_group_name        = var.backwards_compatible ? "${var.basename}-${terraform.workspace}-monitor-rg" : join("_", [var.basename, terraform.workspace])

  tags = merge(
     var.default_tags, 
    {
      Environment = upper(terraform.workspace)
      Location    = lower(var.location)
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )
}