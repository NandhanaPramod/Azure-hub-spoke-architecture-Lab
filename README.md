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

-----------------------------------------------------
Based on the architecture and best practices for Azure hub-spoke deployments, here's the recommended order of service creation after your network setup:
Security Foundation (First Priority):
===================================
Key Vault (keyvault) - This is crucial as other services will need to store secrets

DDoS Protection Plan - (ddos-protection-plan)
Firewall (firewall) - For centralized network security
Bastion Host (bastion) - For secure management access

Identity and Access:
====================
Azure Container Registry (acr) - If you plan to use containers
API Management (apim) - For API management and security
Core Infrastructure Services:
DNS Zone and VNet Link (dns-zone, dns-zone-vnet-link)
NAT Gateway (nat-gateway)
Application Gateway (app-gw)

Monitoring and Management:
==========================
Azure Monitor (monitor)
Alerts (alert)
Dashboard (dashboard)
Microsoft Defender (defender)
Azure Sentinel (sentinel)

Data and Storage Services:
==========================
Storage Account (storage-account)
Microsoft SQL Server (mssql)
Redis Cache (redis)
Recovery Services Vault (recovery-services-vault)

Integration Services:
=====================
Service Bus (service-bus)
Notification Hub (notification-hub)

Compute Resources:
===================
Azure Kubernetes Service (oss-aks)
Virtual Machines (virtual-machine)

Additional Security:
====================
Web Application Firewall (waf)
SAS Token Rotation (sas-rotation)

Important considerations for deployment:
========================================
Dependencies:
Many services will depend on Key Vault for secrets
Network services should be configured before compute resources
Monitoring should be set up early to track the deployment of other services

Security Best Practices:
=========================
Enable Defender for Cloud early in the deployment
Configure network security groups and firewall rules as you deploy each service
Set up monitoring and alerts for each service as it's deployed

Testing:
========
Test connectivity between services after each major component is deployed
Verify security configurations
Check monitoring and alerting

Documentation:
==============
Document the configuration of each service
Keep track of any custom settings or dependencies
