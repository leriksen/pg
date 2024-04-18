resource "azurerm_postgresql_flexible_server" "pg" {
  name                   = "leifpg"
  resource_group_name    = azurerm_resource_group.pg.name
  location               = azurerm_resource_group.pg.location
  sku_name               = module.environment.pg_sku_name
  version                = module.global.pg_version
  administrator_login    = var.pguser
  administrator_password = var.pgpassword
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "db"
  server_id = azurerm_postgresql_flexible_server.pg.id
}