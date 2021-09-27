output "k8s_auth_backend_role_name" {
  value       = one(vault_kubernetes_auth_backend_role.default[*].role_name)
  description = "The kubernetes auth backend role name."
}

output "policy_name" {
  value       = local.policy_name
  description = "Policy name created by this module"
}

output "mount_kvv2_path" {
  value       = local.vault_mount_kvv2_path
  description = "KV v2 mount path"
}

output "mount_postgres_path" {
  value       = local.vault_mount_postgres_path
  description = "The postgres database mount path"
}

output "postgres_database_secret_backend_role" {
  value       = one(vault_database_secret_backend_role.postgres[*].name)
  description = "The postgres database secret backend role name."
}
