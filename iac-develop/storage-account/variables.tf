variable "location" {
  type        = string
  description = "Region name where resources will be created"
}

variable "basename" {
  type        = string
  description = "Prefix used for all resources names"
  default     = "oss"
}

variable "storage_accounts" {
  description = "List of storage accounts to be created"
  type = list(object({
    name_suffix                       = string,       #Storage account name suffix. This should define the intent of storage account
    subnet_names                      = list(string), #List of subnet names from which traffic should be allowed
    virtual_network_name              = string,       #VNet name from which traffic should be allowed
    virtual_network_resource_group    = string,       #The name of the resource group the Virtual Network is located in
    account_kind                      = string,       #Defines the Kind of account
    account_tier                      = string,       #Defines the Tier to use for this storage account
    account_replication_type          = string,       #Defines the type of replication to use for this storage account
    access_tier                       = string,       #Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts
    nfsv3_enabled                     = bool,         #true if NFSv3 protocol is enabled else false
    is_hns_enabled                    = bool,         #true if Hierarchical Namespace is enabled else false
    public_network_access_enabled     = bool,         #true if public access needs to be enabled else false
    infrastructure_encryption_enabled = bool,         #true if infrastructure encryption is enabled else false
    allowed_services                  = list(string), #Specifies whether traffic is bypassed for Logging/Metrics/AzureServices
    allowed_ips                       = list(string), #List of public IPs allowed on storage account
    private_endpoint_subnet           = string,       #Name of the subnet where private endpoint should be created. Leave empty if not required
    private_dns_zone                  = map(string),  #Name of private DNS zone where the DNS record needs to be added
    private_dns_zone_rg               = string,       #Name of the resource group where private dns zone exist
    allow_nested_items_to_be_public   = bool,         #true if blob public access needs to be enabled else false
    static_website_enabled            = bool,         #Flag to enable/disable static website option for storage account
    static_website_index_document     = string
    containers = list(object({
      name                  = string, #The name of the Container which should be created within the Storage Account
      container_access_type = string  #The Access Level configured for this Container
    })),
    file_shares = list(object({
      name  = string, #The name of File Share
      quota = number  #The maximum size of the share, in gigabytes
    }))
  }))
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}

variable "arm_client_id" {
  type        = string
  description = "client ID where DNS zone exists"
}

variable "arm_client_secret" {
  type        = string
  description = "client secret where DNS zone exists"
}

variable "arm_subscription_id" {
  type        = string
  description = "subscription ID where DNS zone exists"
}

variable "sas_rotation_function" {
  type        = string
  description = "Name of the SAS rotation function"
}

variable "sas_rotation_function_rg" {
  type        = string
  description = "SAS rotation function's resource group"
}

variable "backwards_compatible" {
  type        = bool
  default     = false
  description = "This component should be created in <basename>_<tf_workspace> rg. To ensure backwards compatibility with qa and dev should be set to `false`. `true` for other envs."
}

variable "action_group" {
  type        = string
  description = "Name of the action group that should be triggered in case of an alert"
}

variable "prod_diagnostic_settings" {
  type        = bool
  default     = false
  description = "Additional diagnostic settings for sending logs to other log analytics workspaces"
}

variable "prod_client_id" {
  type        = string 
  description = "Client id of production environment"
}

variable "prod_client_secret" {
  type        = string
  description = "Client secret of production environment"
}

variable "prod_subscription_id" {
  type        = string
  description = "Subscription id of production environment"
}