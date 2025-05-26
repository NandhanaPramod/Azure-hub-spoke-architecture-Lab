backwards_compatible = true
action_group         = "oss-hub-prod-alerts"
prod_diagnostic_settings = true
storage_accounts = [
  {
    name_suffix                       = "function",
    subnet_names                      = [],
    virtual_network_name              = "oss_hub_vnet",
    virtual_network_resource_group    = "oss_hub",
    account_kind                      = "StorageV2",
    account_tier                      = "Standard",
    account_replication_type          = "LRS",
    access_tier                       = "Hot",
    nfsv3_enabled                     = false,
    is_hns_enabled                    = false,
    public_network_access_enabled     = false,
    infrastructure_encryption_enabled = true,
    static_website_enabled            = false,
    static_website_index_document     = "index.html",
    allow_nested_items_to_be_public   = false,
    allowed_services                  = ["AzureServices"],
    allowed_ips                       = [],
    private_endpoint_subnet           = "devops",
    private_dns_zone = {
      "privatelink.file.core.windows.net" = "file",
      "privatelink.blob.core.windows.net" = "blob"
    },
    private_dns_zone_rg = "oss_hub",
    containers          = []
    file_shares = [
      {
        name  = "sas-token-file-share"
        quota = 1024
      }
    ]
  },
  {
    name_suffix                       = "artifacts",
    subnet_names                      = [],
    virtual_network_name              = "oss_hub_vnet",
    virtual_network_resource_group    = "oss_hub",
    account_kind                      = "StorageV2",
    account_tier                      = "Standard",
    account_replication_type          = "LRS",
    access_tier                       = "Hot",
    nfsv3_enabled                     = false,
    is_hns_enabled                    = false,
    public_network_access_enabled     = false,
    infrastructure_encryption_enabled = true,
    allow_nested_items_to_be_public   = true,
    static_website_enabled            = false,
    static_website_index_document     = "",
    allowed_services                  = ["AzureServices"],
    # use wildcard cidr to prevent deadlock in gitlabci jobs 
    allowed_ips             = [],
    private_endpoint_subnet = "devops",
    private_dns_zone = {
      "privatelink.blob.core.windows.net" = "blob"
    },
    private_dns_zone_rg = "oss_hub",
    file_shares         = [],
    containers = [
      {
        name                  = "artifacts",
        container_access_type = "blob"
      }
    ]
  }
]
