resource "azurerm_resource_group" "pg" {
  location = module.global.location
  name     = "pg"
}