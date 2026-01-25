output "network_security_group_id" {
  value = module.network.nsg_id
}

output "public_ip" {
  value       = module.network.public_ip_address
  description = "Public IP address of the VM"
}
