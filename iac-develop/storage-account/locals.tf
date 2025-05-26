locals {
  resource_group_name  = "${var.basename}_${terraform.workspace}"
  storage_account_name = { for sa in var.storage_accounts : sa.name_suffix => "${var.basename}${terraform.workspace}${sa.name_suffix}" }
  containers = flatten([
    for sa in var.storage_accounts : [
      for container in sa.containers : {
        name_suffix           = sa.name_suffix
        container_name        = container.name
        container_access_type = container.container_access_type
      }
    ]
  ])
  subnets = concat(flatten([
    for sa in var.storage_accounts : [
      for subnet in sa.subnet_names : {
        name_suffix                    = sa.name_suffix
        subnet_name                    = subnet
        virtual_network_name           = sa.virtual_network_name
        virtual_network_resource_group = sa.virtual_network_resource_group
      }
    ]
    ]), [
    for sa in var.storage_accounts : {
      name_suffix                    = sa.name_suffix
      subnet_name                    = sa.private_endpoint_subnet
      virtual_network_name           = sa.virtual_network_name
      virtual_network_resource_group = sa.virtual_network_resource_group
    } if sa.private_endpoint_subnet != ""
  ])

  tags = merge(
    var.default_tags,
    {
      Environment  = upper(terraform.workspace)
      Location     = lower(var.location)
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )
  file_shares = flatten([
    for sa in var.storage_accounts : [
      for file_share in sa.file_shares : {
        name_suffix     = sa.name_suffix
        file_share_name = file_share.name
        quota           = file_share.quota
      }
    ]
  ])
  private_dns_zone = flatten([
    for sa in var.storage_accounts : [
      for private_dns_zone, subresource in sa.private_dns_zone : {
        name_suffix             = sa.name_suffix
        private_endpoint_subnet = sa.private_endpoint_subnet
        private_dns_zone        = private_dns_zone
        subresource_name        = subresource
        private_dns_zone_rg     = sa.private_dns_zone_rg
      }
    ] if sa.private_endpoint_subnet != ""
  ])

  log_analytics_workspace_name = "${var.basename}-${terraform.workspace}-la-workspace"
  monitor_resource_group_name  = var.backwards_compatible ? "${var.basename}-${terraform.workspace}-monitor-rg" : join("_", [var.basename, terraform.workspace])
}
