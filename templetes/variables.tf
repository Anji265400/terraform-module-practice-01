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


variable "v-net_name" {
  type        = string
  description = "v-net name"

}

variable "subnet_name" {
  type        = string
  description = "subnet name"

}

variable "nic_name" {
  type        = string
  description = "network interface name"

}

variable "nsg_name" {
  type        = string
  description = "network security group name"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key content"
}

variable "computer_name" {
  type        = string
  description = "The computer name of the Virtual Machine."
  
}
