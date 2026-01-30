terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.58.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_network_interface" "main" {
  count               = 2
  name                = "${var.nic_name}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "testconfiguration1${count.index + 1}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id[count.index]
  }
}

locals {
zones = ["1", "2", "3"]
}


resource "azurerm_virtual_machine" "main" {
  count                 = 2
  name                  = "${var.vm_name}-VM-${count.index + 1}"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.main[count.index].id]
  vm_size               = "Standard_B2s"
  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  zones = [element(local.zones, count.index % length(local.zones))]


  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.computer_name}-${count.index + 1}"
    admin_username = data.azurerm_key_vault_secret.example.value
    admin_password = data.azurerm_key_vault_secret.example1.value
  }
  os_profile_linux_config {
    disable_password_authentication = false
    ssh_keys {
      path     = "/home/testadmin/.ssh/authorized_keys"
      key_data = var.ssh_public_key
    }
  }
}
