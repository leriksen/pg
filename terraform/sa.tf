resource "azurerm_storage_account" "sa" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.pg.location
  name                     = "leifdiagsa"
  resource_group_name      = azurerm_resource_group.pg.name
  network_rules {
    default_action = "Allow"
    bypass = [
      "Logging",
      "Metrics",
      "AzureServices"
    ]
  }
}