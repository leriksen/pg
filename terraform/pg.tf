# Azure can take up to a week to cleanup a server group for PG
resource "random_id" "server" {
  keepers = {
    # Generate a new id each time we change this
    id = 1
  }

  byte_length = 2
}
resource "azurerm_postgresql_flexible_server" "pg" {
  name                   = "leifpg${random_id.server.hex}"
  resource_group_name    = azurerm_resource_group.pg.name
  location               = azurerm_resource_group.pg.location
  sku_name               = module.environment.pg_sku_name
  version                = module.global.pg_version
  administrator_login    = var.pguser
  administrator_password = var.pgpassword
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "azure" {
  name             = "allow-access-from-azure-services"
  server_id        = azurerm_postgresql_flexible_server.pg.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "all" {
  name             = "allow-all-ips"
  server_id        = azurerm_postgresql_flexible_server.pg.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "db"
  server_id = azurerm_postgresql_flexible_server.pg.id
}
