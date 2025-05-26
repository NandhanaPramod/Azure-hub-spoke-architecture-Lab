locals {
  tags = merge(
    var.default_tags,
    {
      Environment = upper(var.environment)
      Location    = lower(var.location)
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )
  log_analytics_workspace_name = "${var.basename}-${var.environment}-workspace"
  monitor_resource_group_name  = "${var.basename}_${var.environment}"
}