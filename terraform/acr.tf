resource "azurerm_container_registry" "acr" {
  name                = "acrleif01"
  resource_group_name = azurerm_resource_group.pg.name
  location            = azurerm_resource_group.pg.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "acr_aks_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "acr_azdo_push" {
  principal_id                     = data.azurerm_client_config.current.object_id
  role_definition_name             = "AcrPush"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}