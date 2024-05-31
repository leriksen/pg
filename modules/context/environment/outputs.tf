output "tags" {
  value = merge(
    module.subscription.tags,
    {
      environment = var.environment
    }
  )
}

output "env_sub" {
  value = local.env_sub[var.environment]
}

output "pg_sku_name" {
  value = local.pg_sku_name[var.environment]
}

output "node_version" {
  value = local.node_version[var.environment]
}