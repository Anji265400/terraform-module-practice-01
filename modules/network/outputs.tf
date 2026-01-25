
output "subnet_id" {
  value = azurerm_subnet.internal.id
}

output "nsg_id" {
  value = azurerm_network_security_group.example.id
}

output "public_ip_id" {
  value = azurerm_public_ip.example.id
}

output "public_ip_address" {
  value       = azurerm_public_ip.example.ip_address
  description = "The public IP address"
}
