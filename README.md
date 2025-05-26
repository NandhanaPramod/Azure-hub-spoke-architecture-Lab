# Azure Hub-Spoke Network

A secure, scalable network architecture in Azure that centralizes shared services and security in a hub VNet while connecting multiple spoke VNets. This implementation uses Terraform for infrastructure as code.

## Overview
- Central hub VNet for shared services and security
- Multiple spoke VNets for different workloads
- Centralized security with Azure Firewall
- Private connectivity for sensitive services
- Secure remote access via Azure Bastion

## Quick Start
```bash
terraform init
terraform plan
terraform apply
```

## Architecture
- Hub VNet (10.0.0.0/16) with:
  - Azure Firewall (Premium)
  - Azure Bastion
  - VPN Gateway
  - Shared Services

## Subnets
- Gateway (10.0.0.0/24)
- Firewall (10.0.1.0/24)
- Bastion (10.0.2.0/24)
- Shared (10.0.3.0/24)

## Shared Services
- Key Vault
- Container Registry
- Storage Account
- Log Analytics

## Security
- NSGs on all subnets
- Azure Firewall with threat intelligence
- Private endpoints for sensitive services
- Azure Bastion for secure access
