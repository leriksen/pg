resource "azurerm_postgresql_flexible_server" "example" {
  name                   = "leifpg"
  resource_group_name    = azurerm_resource_group.pg.name
  location               = azurerm_resource_group.pg.location
  sku_name               = module.environment.pg_sku_name
  version                = module.global.pg_version
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
}