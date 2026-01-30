variable "subscription_id" {
  type        = string
  description = "The Subscription ID for the Azure provider."
}

variable "rg_name" {
  type        = string
  description = "The name of the Resource Group."

}

variable "location" {
  type        = string
  description = "The location/region where resources will be created."

}

variable "vm_name" {
  type        = string
  description = "The name of the Virtual Machine."

}

variable "nic_name" {
  type        = string
  description = "network interface name"

}

variable "subnet_id" {
  type        = string
  description = "Subnet ID from network module"
}

variable "public_ip_id" {
  type        = list(string)
  description = "Public IP ID from network module"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key content"
}

variable "computer_name" {
  type        = string
  description = "The computer name of the Virtual Machine."
  
}