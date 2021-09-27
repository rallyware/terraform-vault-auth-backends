locals {
  vault_mount_postgres_path = one(vault_mount.postgres[*].path)
  postgres_ttl_settings     = defaults(var.postgres_ttl_settings, local.postgres_ttl_settings_default)

  postgres_ttl_settings_default = {
    default_ttl = 3600
  }
}
module "postgres_label" {
  source  = "cloudposse/label/null"
  version = "0.24.1"

  attributes = ["postgres"]
  context    = module.this.context
}

resource "vault_mount" "postgres" {
  count = local.enabled ? 1 : 0

  path = module.postgres_label.id
  type = "database"
}

resource "vault_database_secret_backend_connection" "postgres" {
  count = local.enabled ? 1 : 0

  backend = local.vault_mount_postgres_path
  name    = module.postgres_label.id

  postgresql {
    connection_url = var.postgres_connection_url
  }
}

resource "vault_database_secret_backend_role" "postgres" {
  count = local.enabled ? 1 : 0

  backend               = local.vault_mount_postgres_path
  name                  = module.postgres_label.id
  db_name               = one(vault_database_secret_backend_connection.postgres[*].name)
  revocation_statements = var.postgres_revocation_statements
  renew_statements      = var.postgres_renew_statements
  creation_statements   = var.postgres_creation_statements
  default_ttl           = local.postgres_ttl_settings["default_ttl"]
  max_ttl               = local.postgres_ttl_settings["max_ttl"]
}
