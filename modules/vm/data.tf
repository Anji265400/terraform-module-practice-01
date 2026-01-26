data "azurerm_key_vault" "example" {
  name                = "testkv-name"
  resource_group_name = "test_rgkv"
}

data "azurerm_key_vault_secret" "example" {
  name         = "username"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "example1" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.example.id
}