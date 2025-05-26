locals {
  resource_group_name          = "${var.basename}-hub-container-registry-rg"
  log_analytics_workspace_name = "${var.basename}-hub-la-workspace"
  monitor_resource_group_name  = "${var.basename}-hub-monitor-rg"

  tags = merge(
    var.default_tags,
    {
      Environment  = upper(terraform.workspace)
      Location     = lower(var.location)
      ServiceClass = "prod"
    }
  )
}