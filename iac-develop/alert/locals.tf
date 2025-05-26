
locals {
  tags = merge(
    var.default_tags,
    {
      Environment  = upper(terraform.workspace)
      Location     = lower(var.location)
      ServiceClass = terraform.workspace == "prod" ? terraform.workspace : "non-prod"
    }
  )
  resource_group_name = "${var.basename}_${terraform.workspace}"
}
