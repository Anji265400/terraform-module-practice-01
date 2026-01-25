# Terraform Module Practice - Azure Infrastructure

## 📋 Overview

This repository contains modular Terraform configuration for deploying Azure infrastructure, specifically a Virtual Machine with networking components. It demonstrates infrastructure-as-code best practices with:
- Modular architecture
- Key Vault integration for secrets management
- Remote state backend (Azure Storage)
- Multi-environment support with workspaces

## 🏗️ Architecture



## 📁 Project Structure
```
terraform-module-practice/
├── modules/
│ ├── network/
│ │ ├── main.tf # Network resources
│ │ ├── variables.tf # Input variables
│ │ └── outputs.tf # Output values
│ └── vm/
│ ├── main.tf # VM resources
│ ├── variables.tf # Input variables
│ ├── outputs.tf # Output values
│ └── data.tf # Key Vault integration
├── templetes/
│ ├── main.tf # Root module
│ ├── variables.tf # Variables
│ ├── outputs.tf # Outputs
│ ├── provider.tf # Provider config
│ ├── backend.tf # State backend
│ └── terraform.tfvars # Variables (NOT in git)
├── .gitignore # Git ignore rules
└── README.md
```

## 🔐 Security Features

### Key Vault Integration
Sensitive data is stored in Azure Key Vault:
- **Username** → Key Vault secret: `username`
- **Password** → Key Vault secret: `password`
- **Subscription ID** → Key Vault secret: `subscriptionid`

Key Vault details:

Name: testkvn2654
Resource Group: testrg_kv


### Protected Files
The following files are excluded from git (.gitignore):

terraform.tfvars (contains your values)
.terraform/ (Terraform internals)
*.tfstate (State files)
.terraform.lock.hcl (Lock files)



## 🚀 Getting Started

### Prerequisites
1. **Terraform** >= 1.0
2. **Azure CLI** authenticated
3. **Azure Subscription**
4. **SSH Key** (generate with `ssh-keygen -t ed25519`)
5. **Key Vault** set up with secrets

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/YOUR_USERNAME/terraform-module-practice-01.git
cd terraform-module-practice-01/templetes

Create terraform.tfvars:

cat > terraform.tfvars << EOF
subscription_id = "YOUR_SUBSCRIPTION_ID"
rg_name         = "your_resource_group"
location        = "eastus"
vm_name         = "your_vm_name"
v-net_name      = "your_vnet"
subnet_name     = "your_subnet"
nic_name        = "your_nic"
nsg_name        = "your_nsg"
ssh_public_key  = "ssh-ed25519 YOUR_PUBLIC_KEY_CONTENT"
computer_name   = "hostname"
EOF

Initialize Terraform:

terraform init

Plan and Apply:
terraform plan
terraform apply --auto-approve


🔑 SSH Key Setup
Generate SSH Key

ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""

Connect to VM
# Get public IP from terraform output
PUBLIC_IP=$(terraform output -raw public_ip 2>/dev/null)

# SSH into VM
ssh -i ~/.ssh/id_ed25519 testadmin@$PUBLIC_IP

📊 Module Outputs
Network Module Outputs
subnet_id - Subnet ID
public_ip_id - Public IP resource ID
public_ip_address - Actual public IP address
nsg_id - Network Security Group ID
VM Module Outputs
VM public and private IPs (configured via root module outputs)


🔄 Terraform Workflows
Plan Infrastructure Changes

cd templetes
terraform plan

Apply Changes
terraform apply --auto-approve

Destroy Infrastructure
terraform destroy --auto-approve

Switch Workspaces
terraform workspace list      # List workspaces
terraform workspace select Dev # Switch to Dev
terraform workspace new Prod   # Create new workspace


⚙️ Configuration Details
Network Settings
VNet CIDR: 10.0.0.0/16
Subnet CIDR: 10.0.2.0/24
NSG Rule: Allow SSH (port 22) from all sources
VM Settings
Image: Ubuntu 22.04 LTS (Canonical)
Size: Standard_D2s_v3
Admin User: testadmin (from Key Vault)
Authentication: SSH key + Password
OS Disk Auto-delete: Enabled


🔐 Key Vault Setup
Required Secrets
Create these secrets in your Key Vault:
# 1. Username secret
az keyvault secret set --vault-name testkvn2654 --name username --value "testadmin"

# 2. Password secret
az keyvault secret set --vault-name testkvn2654 --name password --value "YourSecurePassword123!"

# 3. Subscription ID secret
az keyvault secret set --vault-name testkvn2654 --name subscriptionid --value "YOUR_SUBSCRIPTION_ID"


📝 Notes
Important Points
Subscription ID - This is public info and safe to include in terraform.tfvars
SSH Public Key - Also public, safe to commit to git
Passwords & Credentials - Always stored in Key Vault, NEVER in git
State File - Stored in Azure Storage backend for team collaboration

Best Practices Applied
✅ Modular architecture for reusability
✅ Remote state management
✅ Secrets in Key Vault
✅ SSH key authentication
✅ Git ignore for sensitive files
✅ Workspace support for multiple environments
