locals {
  enabled     = module.this.enabled
  policy_name = one(vault_policy.default[*].name)
}

data "vault_policy_document" "default" {
  count = local.enabled ? 1 : 0

  rule {
    path         = format("%s/*", local.vault_mount_kvv2_path)
    capabilities = ["read", "list"]
  }
  rule {
    path         = format("%s/*", local.vault_mount_postgres_path)
    capabilities = ["read", "list"]
  }
}

resource "vault_policy" "default" {
  count = local.enabled ? 1 : 0

  name   = module.this.id
  policy = one(data.vault_policy_document.default[*].hcl)
}

