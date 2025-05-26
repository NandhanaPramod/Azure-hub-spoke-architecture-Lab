locals {
  tags = merge(
    var.default_tags,
    {
      Environment = upper(terraform.workspace)
      Location    = lower(var.location)
      ServiceClass = "prod"
    }
  )
}