# Devops-lab

## Mission
* Azure Infrastructure diagram
* Automating Azure infra with Terraform
* Deploying application

## Infrastructure Components
This repository contains Terraform code to deploy the following Azure infrastructure:

### Virtual Network
- Custom VNet with configurable address space
- Multiple subnets with Network Security Groups
- DDoS Protection Plan integration
- Log Analytics Workspace for monitoring

### Security
- Network Security Groups (NSGs) with configurable rules
- DDoS Protection enabled
- Subnet-level security associations

### Monitoring
- Log Analytics Workspace integration
- Diagnostic settings for VNet and NSGs

## Usage
1. Copy the example variables file and update it with your values:
```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Update the following values in terraform.tfvars:
   - `subscription_id`: Your Azure subscription ID
   - `hub_subscription_id`: Your hub subscription ID (if using hub-spoke architecture)

3. Initialize Terraform:
```bash
terraform init
```

4. Review the planned changes:
```bash
terraform plan
```

5. Apply the infrastructure:
```bash
terraform apply
```

## Configuration
The infrastructure can be configured using the following variables:
- `subscription_id`: Azure subscription ID
- `hub_subscription_id`: Hub subscription ID (if using hub-spoke)
- `location`: Azure region
- `environment`: Environment name (dev, prod, non-prod)
- `basename`: Base name for all resources
- `vnet_cidr`: CIDR block for the virtual network
- `subnets`: Map of subnet configurations
- `security_rules`: List of security rules
- `security_group`: List of security groups

## Security Note
Never commit your actual terraform.tfvars file to version control as it may contain sensitive information. The terraform.tfvars.example file is provided as a template.

## About
This project demonstrates infrastructure as code using Terraform to deploy Azure networking resources with security and monitoring capabilities.
