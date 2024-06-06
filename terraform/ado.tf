data "azuredevops_project" "pg" {
  name = "pg"
}

resource "azuredevops_serviceendpoint_azurecr" "acr" {
  project_id                = data.azuredevops_project.pg.id
  resource_group            = azurerm_resource_group.pg.name
  service_endpoint_name     = "tf_sc_acr"
  azurecr_name              = azurerm_container_registry.acr.name
  azurecr_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurecr_subscription_id   = data.azurerm_client_config.current.subscription_id
  azurecr_subscription_name = data.azurerm_subscription.current.display_name
}

resource "azuredevops_pipeline_authorization" "acr" {
  project_id  = data.azuredevops_project.pg.id
  resource_id = azuredevops_serviceendpoint_azurecr.acr.id
  type        = "endpoint"
}

resource "azuredevops_serviceendpoint_kubernetes" "aks" {
  apiserver_url         = "https://${azurerm_kubernetes_cluster.aks.fqdn}"
  authorization_type    = "Kubeconfig"
  project_id            = data.azuredevops_project.pg.id
  service_endpoint_name = "tf_sc_aks"
  kubeconfig {
    kube_config            = azurerm_kubernetes_cluster.aks.kube_config_raw
    accept_untrusted_certs = true
  }
}

resource "azuredevops_pipeline_authorization" "aks" {
  project_id  = data.azuredevops_project.pg.id
  resource_id = azuredevops_serviceendpoint_kubernetes.aks.id
  type        = "endpoint"
}

resource "azuredevops_variable_group" "infra" {
  name         = "infra"
  project_id   = data.azuredevops_project.pg.id
  allow_access = true

  variable {
    name  = "pghost"
    value = azurerm_postgresql_flexible_server.pg.fqdn
  }
  variable {
    name  = "node_version"
    value = module.environment.node_version
  }
  variable {
    name      = "umi"
    value     = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id
    is_secret = true
  }
}