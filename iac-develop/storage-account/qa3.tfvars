basename     = "iskan"
action_group = "iskan-qa3-infra-alerts"

storage_accounts = [
  {
    name_suffix                       = "staticcontent",
    subnet_names                      = [],
    virtual_network_name              = "iskan_qa3_vnet",
    virtual_network_resource_group    = "iskan_qa3",
    account_kind                      = "StorageV2",
    account_tier                      = "Standard",
    account_replication_type          = "LRS",
    access_tier                       = "Hot",
    nfsv3_enabled                     = true,
    is_hns_enabled                    = true,
    public_network_access_enabled     = false,
    infrastructure_encryption_enabled = true,
    static_website_enabled            = false,
    static_website_index_document     = "",
    allowed_services                  = ["AzureServices"],
    # use wildcard cidr to prevent deadlock in gitlabci jobs 
    allowed_ips             = [],
    private_endpoint_subnet = "iskan_qa3_azureapps",
    private_dns_zone = {
      "privatelink.blob.core.windows.net" = "blob"
    },
    private_dns_zone_rg             = "oss_hub",
    allow_nested_items_to_be_public = false,
    file_shares                     = [],
    containers = [
      {
        name                  = "staticcontent",
        container_access_type = "private"
      },
      {
        name                  = "document",
        container_access_type = "private"
      }
    ]
  },
  {
    name_suffix                       = "dhpblob",
    subnet_names                      = [],
    virtual_network_name              = "iskan_qa3_vnet",
    virtual_network_resource_group    = "iskan_qa3",
    account_kind                      = "StorageV2",
    account_tier                      = "Standard",
    account_replication_type          = "LRS",
    access_tier                       = "Hot",
    nfsv3_enabled                     = false,
    is_hns_enabled                    = false,
    public_network_access_enabled     = false,
    infrastructure_encryption_enabled = true,
											  
    static_website_enabled            = false,
    static_website_index_document     = "",
    allowed_services                  = ["AzureServices"],
    # use wildcard cidr to prevent deadlock in gitlabci jobs 
    allowed_ips             = [],
    private_endpoint_subnet = "iskan_qa3_azureapps",
    private_dns_zone = {
      "privatelink.blob.core.windows.net" = "blob"
    },
    private_dns_zone_rg             = "oss_hub",
    allow_nested_items_to_be_public = false,
    file_shares                     = [],
    containers = [
      {
        name                  = "blobappconfig",
        container_access_type = "private"
      },
      {
        name                  = "blobappcontent",
        container_access_type = "private"
      },
      {
        name                  = "blobdocumentcontent",
        container_access_type = "private"
      }
    ]
  },
  {
    name_suffix                       = "ossblob",
    subnet_names                      = [],
    virtual_network_name              = "iskan_qa3_vnet",
    virtual_network_resource_group    = "iskan_qa3",
    account_kind                      = "StorageV2",
    account_tier                      = "Standard",
    account_replication_type          = "LRS",
    access_tier                       = "Hot",
    nfsv3_enabled                     = false,
    is_hns_enabled                    = false,
    public_network_access_enabled     = false,
    infrastructure_encryption_enabled = true,
											  
    static_website_enabled            = false,
    static_website_index_document     = "",
    allowed_services                  = ["AzureServices"],
    # use wildcard cidr to prevent deadlock in gitlabci jobs 
    allowed_ips             = [],
    private_endpoint_subnet = "iskan_qa3_azureapps",
    private_dns_zone = {
      "privatelink.blob.core.windows.net" = "blob"
    },
    private_dns_zone_rg             = "oss_hub",
    allow_nested_items_to_be_public = false,
    file_shares                     = [],
    containers = [
      {
        name                  = "blobappconfig",
        container_access_type = "private"
      }
    ]
  },
  {
    name_suffix                       = "wsdl",
    subnet_names                      = [],
    virtual_network_name              = "iskan_qa3_vnet",
    virtual_network_resource_group    = "iskan_qa3",
    account_kind                      = "StorageV2",
    account_tier                      = "Standard",
    account_replication_type          = "LRS",
    access_tier                       = "Hot",
    nfsv3_enabled                     = false,
    is_hns_enabled                    = false,
    public_network_access_enabled     = false,
    infrastructure_encryption_enabled = true,
    static_website_enabled            = false,
    static_website_index_document     = "",
											 
    allowed_services                  = ["AzureServices"],
    # use wildcard cidr to prevent deadlock in gitlabci jobs 
    allowed_ips             = [],
    private_endpoint_subnet = "iskan_qa3_azureapps",
    private_dns_zone = {
      "privatelink.blob.core.windows.net" = "blob"
    },
    private_dns_zone_rg             = "oss_hub",
    allow_nested_items_to_be_public = true,
    file_shares                     = [],
    containers = [
      {
        name                  = "wsdl",
        container_access_type = "blob"
    }]
  },
  {
    name_suffix                       = "media",
    subnet_names                      = [],
    virtual_network_name              = "",
    virtual_network_resource_group    = "",
    account_kind                      = "StorageV2",
    account_tier                      = "Standard",
    account_replication_type          = "LRS",
    access_tier                       = "Hot",
    nfsv3_enabled                     = false,
    is_hns_enabled                    = false,
    public_network_access_enabled     = true,
    infrastructure_encryption_enabled = true,
    static_website_enabled            = false,
    static_website_index_document     = "",
    allowed_services                  = [],
    allowed_ips                       = [],
    private_endpoint_subnet           = "",
    private_dns_zone                  = {},
    private_dns_zone_rg               = "",
    allow_nested_items_to_be_public   = true,
    file_shares                       = [],
    containers = [
      {
        name                  = "house-images",
        container_access_type = "private"
      },
      {
        name                  = "category-images",
        container_access_type = "private"
      },
      {
        name                  = "common",
        container_access_type = "private"
      },
      {
        name                  = "project-images",
        container_access_type = "private"
    }]
  },
  {
    name_suffix                       = "persistent",
    subnet_names                      = [],
    virtual_network_name              = "iskan_qa3_vnet",
    virtual_network_resource_group    = "iskan_qa3",
    account_kind                      = "StorageV2",
    account_tier                      = "Standard",
    account_replication_type          = "LRS",
    access_tier                       = "Hot",
    nfsv3_enabled                     = true,
    is_hns_enabled                    = true,
    public_network_access_enabled     = false,
    infrastructure_encryption_enabled = true,
    static_website_enabled            = false,
    static_website_index_document     = "",
    allowed_services                  = ["AzureServices"],
    # use wildcard cidr to prevent deadlock in gitlabci jobs 
    allowed_ips             = [],
    private_endpoint_subnet = "iskan_qa3_azureapps",
    private_dns_zone = {
      "privatelink.blob.core.windows.net" = "blob"
    },
    private_dns_zone_rg             = "oss_hub",
    allow_nested_items_to_be_public = false,
    file_shares                     = [],
    containers = [
      {
        name                  = "customtheme",
        container_access_type = "private"
    }]
  }
]

# overwrite default tags from common.tfvars
default_tags = {
  ProjectName  = "ISKAN-ADHA",
  BusinessUnit = "IT",
  ServiceClass = "qa3"
}