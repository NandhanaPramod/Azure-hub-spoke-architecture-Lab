environment             = "qa2"
basename                = "iskan"
resource_group_name     = "iskan_qa2"
servicebus_whitelist_ip = ["80.227.101.131"]
client_name             = "adha"
stack                   = "servicebus"
subscription_id         = "275d1160-29e1-437b-b92c-25ac62a2f47f"
action_group            = "iskan-qa2-infra-alerts"

servicebus_namespaces_queues_data = {
  servicebus1 = {
    custom_name    = "iskan-qa2-servicebus"
    sku            = "Premium"
    capacity       = 1
    zone_redundant = true

    queues = {
      elms-queue = {
        max_delivery_count                      = 10
        requires_duplicate_detection            = false
        duplicate_detection_history_time_window = "PT10M"
        requires_session                        = false
        max_size_in_megabytes                   = 1024
        default_message_ttl                     = "P14D"
        dead_lettering_on_message_expiration    = false
        auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
        enable_partitioning                     = false
        enable_express                          = false
        lock_duration                           = "PT30S"
        enable_batched_operations               = true
        enable_express                          = false
      }
      email-queue = {
        max_delivery_count                      = 10
        requires_duplicate_detection            = false
        duplicate_detection_history_time_window = "PT10M"
        requires_session                        = false
        max_size_in_megabytes                   = 1024
        default_message_ttl                     = "P14D"
        dead_lettering_on_message_expiration    = false
        auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
        enable_partitioning                     = false
        enable_express                          = false
        lock_duration                           = "PT30S"
        enable_batched_operations               = true
        enable_express                          = false
      }
      notification-queue = {
        max_delivery_count                      = 10
        requires_duplicate_detection            = false
        duplicate_detection_history_time_window = "PT10M"
        requires_session                        = false
        max_size_in_megabytes                   = 1024
        default_message_ttl                     = "P14D"
        dead_lettering_on_message_expiration    = false
        auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
        enable_partitioning                     = false
        enable_express                          = false
        lock_duration                           = "PT30S"
        enable_batched_operations               = true
        enable_express                          = false
      }
      sms-queue = {
        max_delivery_count                      = 10
        requires_duplicate_detection            = false
        duplicate_detection_history_time_window = "PT10M"
        requires_session                        = false
        max_size_in_megabytes                   = 1024
        default_message_ttl                     = "P14D"
        dead_lettering_on_message_expiration    = false
        auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
        enable_partitioning                     = false
        enable_express                          = false
        lock_duration                           = "PT30S"
        enable_batched_operations               = true
        enable_express                          = false
      }
      undertaking-queue = {
        max_delivery_count                      = 10
        requires_duplicate_detection            = false
        duplicate_detection_history_time_window = "PT10M"
        requires_session                        = false
        max_size_in_megabytes                   = 1024
        default_message_ttl                     = "P14D"
        dead_lettering_on_message_expiration    = false
        auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
        enable_partitioning                     = false
        enable_express                          = false
        lock_duration                           = "PT30S"
        enable_batched_operations               = true
        enable_express                          = false
      }
      ext-queue = {
        max_delivery_count                      = 10
        requires_duplicate_detection            = false
        duplicate_detection_history_time_window = "PT10M"
        requires_session                        = false
        max_size_in_megabytes                   = 1024
        default_message_ttl                     = "P14D"
        dead_lettering_on_message_expiration    = false
        auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
        enable_partitioning                     = false
        enable_express                          = false
        lock_duration                           = "PT30S"
        enable_batched_operations               = true
        enable_express                          = false
      }
      gis-queue = {
        max_delivery_count                      = 10
        requires_duplicate_detection            = false
        duplicate_detection_history_time_window = "PT10M"
        requires_session                        = false
        max_size_in_megabytes                   = 1024
        default_message_ttl                     = "P14D"
        dead_lettering_on_message_expiration    = false
        auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
        enable_partitioning                     = false
        enable_express                          = false
        lock_duration                           = "PT30S"
        enable_batched_operations               = true
        enable_express                          = false
      }
      migration-queue = {
        max_delivery_count                      = 10
        requires_duplicate_detection            = false
        duplicate_detection_history_time_window = "PT10M"
        requires_session                        = false
        max_size_in_megabytes                   = 1024
        default_message_ttl                     = "P14D"
        dead_lettering_on_message_expiration    = false
        auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
        enable_partitioning                     = false
        enable_express                          = false
        lock_duration                           = "PT30S"
        enable_batched_operations               = true
        enable_express                          = false
      }
    }
  }
}

# overwrite default tags from common.tfvars
default_tags = {
  ProjectName  = "ISKAN-ADHA",
  BusinessUnit = "IT",
  ServiceClass = "non-prod"
}
