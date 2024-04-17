module "globals" {
  source = "../globals"
}

locals {
  env_sub = {
    dev = "NP"
  }

  pg_sku_name = {
    dev = "B_Standard_B1ms"
  }
}

module "subscription" {
  source = "../subscription"
  subscription = local.env_sub[var.environment]
}
