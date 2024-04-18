resource "azurerm_key_vault" "kv" {
  location                 = azurerm_resource_group.pg.location
  name                     = "leifpgkv"
  resource_group_name      = azurerm_resource_group.pg.name
  sku_name                 = "standard"
  tenant_id                = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled = false
}