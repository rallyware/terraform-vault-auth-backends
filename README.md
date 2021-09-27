<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k8s_label"></a> [k8s\_label](#module\_k8s\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_postgres_label"></a> [postgres\_label](#module\_postgres\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.24.1 |

## Resources

| Name | Type |
|------|------|
| [vault_database_secret_backend_connection.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_connection) | resource |
| [vault_database_secret_backend_role.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_role) | resource |
| [vault_kubernetes_auth_backend_role.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_role) | resource |
| [vault_mount.kvv2](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_mount.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy_document.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_backend"></a> [k8s\_backend](#input\_k8s\_backend) | Unique name of the kubernetes backend to configure. | `string` | n/a | yes |
| <a name="input_postgres_connection_url"></a> [postgres\_connection\_url](#input\_postgres\_connection\_url) | A URL containing connection information. For example: `postgres://username:password@host:port/database` | `string` | n/a | yes |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_k8s_bound_service_account_names"></a> [k8s\_bound\_service\_account\_names](#input\_k8s\_bound\_service\_account\_names) | List of service account names able to access this role. If set to `[*]` all names are allowed, both this and `k8s_bound_service_account_namespaces` can not be `*`. | `list(string)` | `null` | no |
| <a name="input_k8s_bound_service_account_namespaces"></a> [k8s\_bound\_service\_account\_namespaces](#input\_k8s\_bound\_service\_account\_namespaces) | List of namespaces allowed to access this role. If set to `[*]` all namespaces are allowed, both this and `k8s_bound_service_account_names` can not be set to `*`. | `list(string)` | `null` | no |
| <a name="input_k8s_token_settings"></a> [k8s\_token\_settings](#input\_k8s\_token\_settings) | token\_type:<br>  The type of token that should be generated. <br>  Can be `service`, `batch`, or `default` to use the mount's tuned default (which unless changed will be service tokens). <br>  For token store roles, there are two additional possibilities: `default-service` and `default-batch` which specify the type to return unless the client requests a different type at generation time.<br>audience:<br>  Audience claim to verify in the JWT.<br>token\_ttl:<br>  The incremental lifetime for generated tokens in number of seconds. <br>  Its current value will be referenced at renewal time.<br>token\_max\_ttl:<br>  The maximum lifetime for generated tokens in number of seconds. <br>  Its current value will be referenced at renewal time.<br>token\_period:<br>  If set, indicates that the token generated using this role should never expire. <br>  The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field.<br>token\_explicit\_max\_ttl:<br>  If set, will encode an explicit max TTL onto the token in number of seconds. <br>  This is a hard cap even if `token_ttl` and `token_max_ttl` would otherwise allow a renewal.<br>token\_num\_uses:<br>  The period, if any, in number of seconds to set on the token.<br>token\_policies:<br>  List of policies to encode onto generated tokens. <br>  Depending on the auth method, this list may be supplemented by user/group/other values.<br>token\_bound\_cidrs:<br>  List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well.<br>token\_no\_default\_policy:<br>  If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token\_policies. | <pre>object({<br>    token_type              = optional(string)<br>    audience                = optional(string)<br>    token_ttl               = optional(number)<br>    token_max_ttl           = optional(number)<br>    token_period            = optional(number)<br>    token_explicit_max_ttl  = optional(number)<br>    token_num_uses          = optional(number)<br>    token_policies          = optional(list(string))<br>    token_bound_cidrs       = optional(list(string))<br>    token_no_default_policy = optional(bool)<br>  })</pre> | <pre>{<br>  "token_no_default_policy": true,<br>  "token_ttl": 3600<br>}</pre> | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_postgres_creation_statements"></a> [postgres\_creation\_statements](#input\_postgres\_creation\_statements) | The postgres database statements to execute when creating a user. | `list(string)` | <pre>[<br>  "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",<br>  "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO \"{{name}}\";",<br>  "GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public to \"{{name}}\";"<br>]</pre> | no |
| <a name="input_postgres_renew_statements"></a> [postgres\_renew\_statements](#input\_postgres\_renew\_statements) | The postgres database statements to execute when renewing a user. | `list(string)` | <pre>[<br>  "ALTER ROLE \"{{name}}\" VALID UNTIL '{{expiration}}';"<br>]</pre> | no |
| <a name="input_postgres_revocation_statements"></a> [postgres\_revocation\_statements](#input\_postgres\_revocation\_statements) | The postgres database statements to execute when revoking a user. | `list(string)` | <pre>[<br>  "ALTER ROLE \"{{name}}\" NOLOGIN;"<br>]</pre> | no |
| <a name="input_postgres_ttl_settings"></a> [postgres\_ttl\_settings](#input\_postgres\_ttl\_settings) | default\_ttl:<br>  The default number of seconds for leases for this role.<br>max\_ttl:<br>  The maximum number of seconds for leases for this role. | <pre>object({<br>    default_ttl = optional(number)<br>    max_ttl     = optional(number)<br>  })</pre> | <pre>{<br>  "default_ttl": 3600,<br>  "max_ttl": 4800<br>}</pre> | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_auth_backend_role_name"></a> [k8s\_auth\_backend\_role\_name](#output\_k8s\_auth\_backend\_role\_name) | The kubernetes auth backend role name. |
| <a name="output_mount_kvv2_path"></a> [mount\_kvv2\_path](#output\_mount\_kvv2\_path) | KV v2 mount path |
| <a name="output_mount_postgres_path"></a> [mount\_postgres\_path](#output\_mount\_postgres\_path) | The postgres database mount path |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Policy name created by this module |
| <a name="output_postgres_database_secret_backend_role"></a> [postgres\_database\_secret\_backend\_role](#output\_postgres\_database\_secret\_backend\_role) | The postgres database secret backend role name. |
<!-- END_TF_DOCS --> 