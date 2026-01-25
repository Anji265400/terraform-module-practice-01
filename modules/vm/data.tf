data "azurerm_key_vault" "example" {
  name                = "testkvn2654"
  resource_group_name = "testrg_kv"
}

data "azurerm_key_vault_secret" "example" {
  name         = "username"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "example1" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.example.id
}