terraform {
  backend "azurerm" {
    resource_group_name  = "test-rg"
    storage_account_name = "testaccountsampltf"
    container_name       = "sampletfcontainer"
    key                  = "terraform.tfstate"
  }
}
