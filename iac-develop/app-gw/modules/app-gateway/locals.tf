locals {
  action_groups = flatten([
    for alert in var.alerts : {
      action_group = alert.action_group,
      alert_name   = alert.name
    }
  ])
  log_analytics_workspace_name = "${var.basename}-${terraform.workspace}-la-workspace"
  monitor_resource_group_name  = "${var.basename}-${terraform.workspace}-monitor-rg"
}