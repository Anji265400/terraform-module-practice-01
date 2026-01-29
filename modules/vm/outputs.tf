output "vm_names" {
  value = azurerm_virtual_machine.main[*].name
}
