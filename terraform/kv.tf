resource "azurerm_key_vault" "kv" {
  location                  = azurerm_resource_group.pg.location
  name                      = "leifpgkv"
  resource_group_name       = azurerm_resource_group.pg.name
  sku_name                  = "standard"
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled  = false
  enable_rbac_authorization = true
}

resource "azurerm_role_assignment" "pg_kv_writer" {
  principal_id         = data.azurerm_client_config.current.object_id
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
}

resource "azurerm_key_vault_secret" "pguser" {
  depends_on   = [
    azurerm_role_assignment.pg_kv_writer
  ]
  key_vault_id = azurerm_key_vault.kv.id
  name         = "pguser"
  value        = var.pguser
}

resource "azurerm_key_vault_secret" "pgpassword" {
  depends_on   = [
    azurerm_role_assignment.pg_kv_writer
  ]
  key_vault_id = azurerm_key_vault.kv.id
  name         = "pgpassword"
  value        = var.pgpassword
}

resource "azurerm_role_assignment" "aks_kv_reader" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
}
