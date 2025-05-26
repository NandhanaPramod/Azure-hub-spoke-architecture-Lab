locals {
  resource_group_name = "${var.basename}_${terraform.workspace}"
  tags = merge(
    var.default_tags,
    {
      Environment  = upper(terraform.workspace)
      Location     = lower(var.location)
      ServiceClass = "prod"
    }
  )
}