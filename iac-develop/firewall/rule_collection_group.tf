resource "azurerm_firewall_policy_rule_collection_group" "hub-dev-admin" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "hub-dev-admin"
  priority           = 1000

  network_rule_collection {
    action   = "Allow"
    name     = "hub-dev-admin"
    priority = 1001

    rule {
      destination_addresses = [
        "10.50.4.0/22",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "22",
      ]
      name = "ssh"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.1.32/27",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "185.66.19.248",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "500",
      ]
      name = "ipsec"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "185.66.19.248",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "4500",
      ]
      name = "ipsec1"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.50.1.64/26",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "22",
      ]
      name = "ssh-devops"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.1.32/27",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.50.4.192/26",
        "10.50.5.0/24",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "1433",
      ]
      name = "vpn-hub-dev-database"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.201.13.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.50.50",
        "10.95.50.51",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "53",
      ]
      name = "aks-dev-hub-adha-DNS"
      protocols = [
        "UDP",
      ]
      source_addresses = [
        "*",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.50.0.0/22",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "1-65535",
      ]
      name = "TEST_RL"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.0.0/22",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.50.1.76/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "hub-acr"
      protocols = [
        "TCP",
        "Any",
        "UDP",
        "ICMP",
      ]
      source_addresses = [
        "10.50.1.64/26",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.0.0/16",
        "192.168.19.0/24",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "80",
        "443",
      ]
      name = "hub-adha"
      protocols = [
        "Any",
        "TCP",
        "UDP",
        "ICMP",
      ]
      source_addresses = [
        "10.50.0.0/23",
        "10.50.3.0/24",
      ]
      source_ip_groups = []
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "aks-dev-hub" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "aks-dev-hub"
  priority           = 100

  application_rule_collection {
    action   = "Allow"
    name     = "aks-hub-admin"
    priority = 10001

    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "*.hcp.uaenorth.azmk8s.io",
      ]
      destination_urls = []
      name             = "node-api-comm"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "mcr.microsoft.com",
        "*.data.mcr.microsoft.com",
      ]
      destination_urls = []
      name             = "node-mcr"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "management.azure.com",
      ]
      destination_urls = []
      name             = "aks-k8s-api"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "login.microsoftonline.com",
      ]
      destination_urls = []
      name             = "aks-aad"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "azure.archive.ubuntu.com",
      ]
      destination_urls = []
      name             = "ubuntu-archive"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 80
        type = "Http"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "changelogs.ubuntu.com",
      ]
      destination_urls = []
      name             = "ubuntu-changelog"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 80
        type = "Http"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "*.ods.opinsights.azure.com",
      ]
      destination_urls = []
      name             = "aks-defender"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "*.oms.opinsights.azure.com",
      ]
      destination_urls = []
      name             = "aks-law"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "uaenorth.dp.kubernetesconfiguration.azure.com",
      ]
      destination_urls = []
      name             = "aks-extension-conf-fetch"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "*.docker.io",
      ]
      destination_urls = []
      name             = "docker.io"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
      protocols {
        port = 80
        type = "Http"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "registry.k8s.io",
      ]
      destination_urls = []
      name             = "registry.k8s.io"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "*.pkg.dev",
      ]
      destination_urls = []
      name             = "docker-packages"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "*.docker.com",
      ]
      destination_urls = []
      name             = "docker-images"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 443
        type = "Https"
      }
      protocols {
        port = 80
        type = "Http"
      }
    }
    rule {
      destination_addresses = []
      destination_fqdn_tags = []
      destination_fqdns = [
        "*.centos.org",
      ]
      destination_urls = []
      name             = "centsorg"
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
      terminate_tls    = false
      web_categories   = []

      protocols {
        port = 80
        type = "Http"
      }
      protocols {
        port = 443
        type = "Https"
      }
    }
  }

  network_rule_collection {
    action   = "Allow"
    name     = "aks-dev-hub"
    priority = 101

    rule {
      destination_addresses = [
        "192.168.19.26/32",
        "192.168.19.238/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
        "2099",
      ]
      name = "app-dev-hub-adha-dmz"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.56.45",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "80",
      ]
      name = "app-dev-hub-adha-cdcvmahdevgap01"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.238",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "app-dev-hub-adha-stage-cba"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.62.32/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "9710",
      ]
      name = "app-dev-hub-adha-sms"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.60",
        "192.168.19.52",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "25",
      ]
      name = "app-dev-hub-adha-smtp"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.26",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "app-dev-hub-adha-stage-ecm"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.238",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "app-dev-hub-adha-stage-website"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = []
      destination_fqdns = [
        "DBUAT03A.adha.ae",
      ]
      destination_ip_groups = []
      destination_ports = [
        "1528",
      ]
      name = "dev-to-adha-cba-db-domain"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.254.23.58",
        "10.254.28.70",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "*",
      ]
      name = "dev-hub-adha-esri-dof"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.5.0/25",
        "10.50.6.0/23"
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "52.1.184.176",
        "34.194.164.123",
        "18.215.138.58",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "registry-1.docker.io"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "185.125.190.36",
        "185.125.190.39",
        "91.189.91.38",
        "91.189.91.39",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "80",
        "443",
      ]
      name = "security.ubuntu.com"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "91.189.91.38",
        "185.125.190.36",
        "91.189.91.39",
        "185.125.190.39",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "80",
        "443",
      ]
      name = "archive.ubuntu.com"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "217.165.206.232",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "stg.lll.gov.ae"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "5.194.255.186",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "www.teyaseer.ae"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "142.250.181.33",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "ossbankfab.page.link"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "5.194.254.221",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "stage-api.abudhabi.ae"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "213.42.56.82",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "stg-id.uaepass.ae"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "213.42.85.87",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "id.uaepass.ae"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "20.31.227.25",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "notification-hub"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "13.86.218.248",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "appinsights"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = []
      destination_fqdns = [
        "ntp.ubuntu.com",
      ]
      destination_ip_groups = []
      destination_ports = [
        "123",
      ]
      name = "aks-ntp"
      protocols = [
        "UDP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "AzureMonitor",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "aks-monitor"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "35.190.247.0/24",
        "64.233.160.0/19",
        "66.102.0.0/20",
        "66.249.80.0/20",
        "72.14.192.0/18",
        "74.125.0.0/16",
        "108.177.8.0/21",
        "173.194.0.0/16",
        "209.85.128.0/17",
        "216.58.192.0/19",
        "216.239.32.0/19",
        "172.217.0.0/19",
        "172.217.32.0/20",
        "172.217.128.0/19",
        "172.217.160.0/20",
        "172.217.192.0/19",
        "172.253.56.0/21",
        "172.253.112.0/20",
        "108.177.96.0/19",
        "35.191.0.0/16",
        "130.211.0.0/22",
        "142.250.220.0/24",
        "142.250.221.0/24",
        "142.251.0.0/16",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "465",
        "25",
      ]
      name = "smtp-gmail"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "23.212.160.83",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
        "80",
      ]
      name = "oracle-download-site"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.0.0/16",
      ]
      source_ip_groups = []
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "hub-devops" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "hub-devops"
  priority           = 7000

  network_rule_collection {
    action   = "Allow"
    name     = "hub-sonarqube"
    priority = 7001

    rule {
      destination_addresses = [
        "10.50.1.132/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "5432",
      ]
      name = "sonarqube-db"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.1.69/32",
      ]
      source_ip_groups = []
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "hub-qa-admin" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "hub-qa-admin"
  priority           = 2000
}

resource "azurerm_firewall_policy_rule_collection_group" "qa-hub" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "qa-hub"
  priority           = 3000

  network_rule_collection {
    action   = "Allow"
    name     = "qa-hub-adha"
    priority = 3001

    rule {
      destination_addresses = [
        "192.168.19.26/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
        "2099",
      ]
      name = "qa-to-adha-ecms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.9.0/25",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.238/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "qa-to-adha-cba"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.9.0/25",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.60",
        "192.168.19.52",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "25",
      ]
      name = "qa-hub-adha-smtp"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.9.0/25",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.62.32/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "9710",
      ]
      name = "qa-hub-adha-sms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.9.0/25",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = []
      destination_fqdns = [
        "DBUAT03A.adha.ae",
      ]
      destination_ip_groups = []
      destination_ports = [
        "1528",
      ]
      name = "qa-to-adha-cba-db-domain"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.9.0/25",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.54.13/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "1528",
      ]
      name = "qa-to-adha-cba-db-ip"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.9.0/25",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.254.23.58/32",
        "10.254.28.70/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "*",
      ]
      name = "qa-hub-adha-esri-dof"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.9.0/25",
      ]
      source_ip_groups = []
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "pp-hub" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "pp-hub"
  priority           = 4000

  network_rule_collection {
    action   = "Allow"
    name     = "pp-hub-adha"
    priority = 4001

    rule {
      destination_addresses = [
        "192.168.19.26/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
        "2099",
      ]
      name = "pp-to-adha-ecms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.13.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.238/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "pp-to-adha-cba"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.13.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.60",
        "192.168.19.52",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "25",
      ]
      name = "pp-hub-adha-smtp"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.13.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.62.32/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "9710",
      ]
      name = "pp-hub-adha-sms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.13.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = []
      destination_fqdns = [
        "DBUAT03A.adha.ae",
      ]
      destination_ip_groups = []
      destination_ports = [
        "1528",
      ]
      name = "pp-to-adha-cba-db-domain"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.13.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.254.23.58/32",
        "10.254.28.70/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "*",
      ]
      name = "pp-hub-adha-esri-dof"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.13.0/24",
      ]
      source_ip_groups = []
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "prod-hub" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "prod-hub"
  priority           = 5000

  network_rule_collection {
    action   = "Allow"
    name     = "prod-hub-adha"
    priority = 5001

    rule {
      destination_addresses = [
        "192.168.19.26/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
        "2099",
      ]
      name = "prod-to-adha-stageecms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.238/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "prod-to-adha-cba"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.60",
        "192.168.19.52",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "25",
      ]
      name = "prod-hub-adha-smtp"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.62.32/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "9710",
      ]
      name = "prod-hub-adha-sms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = []
      destination_fqdns = [
        "DBADHACDCS.adha.ae",
        "DBADHAIDCS.adha.ae",
      ]
      destination_ip_groups = []
      destination_ports = [
        "1529",
      ]
      name = "prod-to-adha-cba-db-domain"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.25/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
        "2099",
      ]
      name = "prod-to-adha-ecm"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.11/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "prod-to-adha-prodcba"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.160/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "prod-to-adha-prodWwebsite"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = []
      destination_fqdns = [
        "gis.adha.ae",
      ]
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "prod-hub-adha-esri-gis"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.254.28.111",
        "10.254.28.70",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "*",
      ]
      name = "prod-hub-adha-esri-dof"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.17.0/24",
      ]
      source_ip_groups = []
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "DefaultNetworkRuleCollectionGroup" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "DefaultNetworkRuleCollectionGroup"
  priority           = 200
}

resource "azurerm_firewall_policy_rule_collection_group" "qa2-hub" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "qa2-hub"
  priority           = 8000

  network_rule_collection {
    action   = "Allow"
    name     = "qa2-hub-adha"
    priority = 8001

    rule {
      destination_addresses = [
        "192.168.19.26/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
        "2099",
      ]
      name = "qa2-to-adha-ecms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.22.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.238/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "qa2-to-adha-cba"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.22.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.60",
        "192.168.19.52",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "25",
      ]
      name = "qa2-hub-adha-smtp"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.22.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.62.32/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "9710",
      ]
      name = "qa2-hub-adha-sms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.22.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = []
      destination_fqdns = [
        "DBUAT03A.adha.ae",
      ]
      destination_ip_groups = []
      destination_ports = [
        "1528",
      ]
      name = "qa2-to-adha-cba-db-domain"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.22.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.254.23.58",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "*",
      ]
      name = "qa2-hub-adha-esri-dof"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.22.0/23",
      ]
      source_ip_groups = []
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "qa3-hub" {
  firewall_policy_id = azurerm_firewall_policy.this.id
  name               = "qa3-hub"
  priority           = 9000

  network_rule_collection {
    action   = "Allow"
    name     = "qa3-hub-adha"
    priority = 9001

    rule {
      destination_addresses = [
        "192.168.19.26/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
        "2099",
      ]
      name = "qa3-to-adha-ecms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.26.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.238/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "443",
      ]
      name = "qa3-to-adha-cba"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.26.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "192.168.19.60",
        "192.168.19.52",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "25",
      ]
      name = "qa3-hub-adha-smtp"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.26.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.95.62.32/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "9710",
      ]
      name = "qa3-hub-adha-sms"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.26.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = []
      destination_fqdns = [
        "DBUAT03A.adha.ae",
      ]
      destination_ip_groups = []
      destination_ports = [
        "1528",
      ]
      name = "qa3-to-adha-cba-db-domain"
      protocols = [
        "TCP",
      ]
      source_addresses = [
        "10.50.26.0/23",
      ]
      source_ip_groups = []
    }
    rule {
      destination_addresses = [
        "10.254.23.58/32",
      ]
      destination_fqdns     = []
      destination_ip_groups = []
      destination_ports = [
        "*",
      ]
      name = "qa3-hub-adha-esri-dof"
      protocols = [
        "Any",
      ]
      source_addresses = [
        "10.50.26.0/23",
      ]
      source_ip_groups = []
    }
  }
}