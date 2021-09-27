locals {
  vault_mount_kvv2_path = one(vault_mount.kvv2[*].path)
  k8s_token_settings    = defaults(var.k8s_token_settings, local.k8s_token_settings_default)

  k8s_token_settings_default = {
    token_no_default_policy = true
    token_ttl               = 3600
  }
}

module "k8s_label" {
  source  = "cloudposse/label/null"
  version = "0.24.1"

  attributes = ["k8s"]
  context    = module.this.context
}

resource "vault_mount" "kvv2" {
  count = local.enabled ? 1 : 0

  path = module.k8s_label.id
  type = "kv-v2"
}

resource "vault_kubernetes_auth_backend_role" "default" {
  count = local.enabled ? 1 : 0

  backend                          = var.k8s_backend
  role_name                        = module.k8s_label.id
  bound_service_account_names      = var.k8s_bound_service_account_names
  bound_service_account_namespaces = var.k8s_bound_service_account_namespaces
  audience                         = local.k8s_token_settings["audience"]
  token_type                       = local.k8s_token_settings["token_type"]
  token_no_default_policy          = local.k8s_token_settings["token_no_default_policy"]
  token_policies                   = concat([local.policy_name], local.k8s_token_settings["token_policies"])
  token_bound_cidrs                = local.k8s_token_settings["token_bound_cidrs"]
  token_ttl                        = local.k8s_token_settings["token_ttl"]
  token_max_ttl                    = local.k8s_token_settings["token_max_ttl"]
  token_period                     = local.k8s_token_settings["token_period"]
  token_num_uses                   = local.k8s_token_settings["token_num_uses"]
  token_explicit_max_ttl           = local.k8s_token_settings["token_explicit_max_ttl"]
}
