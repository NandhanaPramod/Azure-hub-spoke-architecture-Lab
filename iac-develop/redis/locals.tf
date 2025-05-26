locals {
  tags = merge(
    var.default_tags,
    {
      Environment  = upper(terraform.workspace)
      Location     = lower(var.location)
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )
  resource_group_name          = "${var.basename}_${terraform.workspace}"
  log_analytics_workspace_name = "${var.basename}-${terraform.workspace}-la-workspace"
  monitor_resource_group_name  = var.backwards_compatible ? "${var.basename}-${terraform.workspace}-monitor-rg" : join("_", [var.basename, terraform.workspace])
}
