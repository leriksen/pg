resource "azurerm_kubernetes_cluster" "aks" {
  location            = azurerm_resource_group.pg.location
  name                = azurerm_resource_group.pg.name
  resource_group_name = azurerm_resource_group.pg.name
  dns_prefix          = "leifpgaks"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    upgrade_settings {
      max_surge = "10%"
    }
  }
  identity {
    type = "SystemAssigned"
  }
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
}