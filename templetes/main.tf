resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}


module "network" {
  source      = "../modules/network"
  rg_name     = azurerm_resource_group.rg.name
  location    = var.location
  v-net_name  = var.v-net_name
  subnet_name = var.subnet_name
  nsg_name    = var.nsg_name
  nic_name    = var.nic_name

}

module "vm" {
  source          = "../modules/vm"
  subscription_id = var.subscription_id
  rg_name         = azurerm_resource_group.rg.name
  location        = var.location
  vm_name         = var.vm_name
  nic_name        = var.nic_name
  subnet_id       = module.network.subnet_id
  public_ip_id    = module.network.public_ip_id
  ssh_public_key  = var.ssh_public_key
  computer_name   = var.computer_name
}


# resource "azurerm_resource_group" "rg" {
#   name     = "${var.rg_name}-${terraform.workspace}"
#   location = var.location
# }


# module "network" {
#   source      = "../modules/network"
#   rg_name     = azurerm_resource_group.rg.name
#   location    = var.location
#   v-net_name  = "${var.v-net_name}-${terraform.workspace}"
#   subnet_name = "${var.subnet_name}-${terraform.workspace}"
#   nsg_name    = "${var.nsg_name}-${terraform.workspace}"
#   nic_name    = "${var.nic_name}-${terraform.workspace}"

# }

# module "vm" {
#   source          = "../modules/vm"
#   subscription_id = var.subscription_id
#   rg_name         = azurerm_resource_group.rg.name
#   location        = var.location
#   vm_name         = "${var.vm_name}-${terraform.workspace}"
#   nic_name        = "${var.nic_name}-${terraform.workspace}"
#   subnet_id       = module.network.subnet_id
#   public_ip_id    = module.network.public_ip_id
#   ssh_public_key  = var.ssh_public_key
#   computer_name   = "${var.computer_name}-${terraform.workspace}-Vm"
# }