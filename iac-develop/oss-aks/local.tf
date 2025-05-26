locals {
  # Agent tags to be assigned
  sysagents_tags = {
    agent = "sysnodepool-agent"
  }
  sysagents_labels = {
    agent     = "sysnpagent",
    component = "mic"
  }
  useragents_tags = merge(
    var.default_tags,
    {
      Environment  = upper(terraform.workspace)
      Location     = lower(var.location)
      ServiceClass = length(regexall("prod", terraform.workspace)) > 0 ? "prod" : "non-prod"
    },
    {
      agent = "usernodepool-agent"
    }
  )
  storage_account_contributor_access = [
    {
      name     = replace("${var.basename}${terraform.workspace}staticcontent", "/-(cba|blue)/", ""),
      required = true
      type     = "static"
    },
    {
      name     = replace("${var.basename}${terraform.workspace}persistent", "/-(cba|blue)/", ""),
      required = var.persistent_sa_role_required
      type     = "persistent"
    }
  ]

  tags = merge(
    var.default_tags,
    {
      Environment  = upper(terraform.workspace)
      Location     = lower(var.location)
      ServiceClass = length(regexall("prod", terraform.workspace)) > 0 ? "prod" : "non-prod"
    }
  )

  pod_identity_values = templatefile("${path.module}/values/pod_identity_values.yaml.tmpl", {
    resourceID = azurerm_user_assigned_identity.this.id
    clientID   = azurerm_user_assigned_identity.this.client_id
  })

  pod_identity_values_hash = sha256(local.pod_identity_values)

  log_analytics_workspace_name = replace("${var.basename}-${terraform.workspace}-la-workspace", "/-(cba|blue)/", "")
  monitor_resource_group_name  = replace(var.backwards_compatible ? "${var.basename}-${terraform.workspace}-monitor-rg" : join("_", [var.basename, terraform.workspace]), "/-(cba|blue)/", "")
  nodepools                    = concat([{ "usernodepool_name" : "sysnodepool", "useragents_max_count" : var.sysagents_max_count, "useragents_min_count" : var.sysagents_min_count }], var.usernodepool)
  deployment_alerts = flatten([
    for alert in var.deployment_alerts : [
      for deployment in var.deployments : merge(alert, { "deployment" = deployment })
    ]
  ])
}
