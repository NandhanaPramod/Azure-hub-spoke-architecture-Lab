enable_non_ssl_port           = false
public_network_access_enabled = false
enable_authentication         = true
patch_schedule = {
  day_of_week    = "Saturday"
  start_hour_utc = 0
}
private_dns_zone    = "privatelink.redis.cache.windows.net"
private_dns_zone_rg = "oss_hub"
redis_version        = 6
