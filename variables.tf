variable "k8s_backend" {
  type        = string
  description = "Unique name of the kubernetes backend to configure."
}

variable "k8s_bound_service_account_names" {
  type        = list(string)
  default     = null
  description = "List of service account names able to access this role. If set to `[*]` all names are allowed, both this and `k8s_bound_service_account_namespaces` can not be `*`."
}

variable "k8s_bound_service_account_namespaces" {
  type        = list(string)
  default     = null
  description = "List of namespaces allowed to access this role. If set to `[*]` all namespaces are allowed, both this and `k8s_bound_service_account_names` can not be set to `*`."
}

variable "k8s_token_settings" {
  type = object({
    token_type              = optional(string)
    audience                = optional(string)
    token_ttl               = optional(number)
    token_max_ttl           = optional(number)
    token_period            = optional(number)
    token_explicit_max_ttl  = optional(number)
    token_num_uses          = optional(number)
    token_policies          = optional(list(string))
    token_bound_cidrs       = optional(list(string))
    token_no_default_policy = optional(bool)
  })
  default = {
    token_no_default_policy = true
    token_ttl               = 3600
  }
  description = <<-DOC
      token_type:
        The type of token that should be generated. 
        Can be `service`, `batch`, or `default` to use the mount's tuned default (which unless changed will be service tokens). 
        For token store roles, there are two additional possibilities: `default-service` and `default-batch` which specify the type to return unless the client requests a different type at generation time.
      audience:
        Audience claim to verify in the JWT.
      token_ttl:
        The incremental lifetime for generated tokens in number of seconds. 
        Its current value will be referenced at renewal time.
      token_max_ttl:
        The maximum lifetime for generated tokens in number of seconds. 
        Its current value will be referenced at renewal time.
      token_period:
        If set, indicates that the token generated using this role should never expire. 
        The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field.
      token_explicit_max_ttl:
        If set, will encode an explicit max TTL onto the token in number of seconds. 
        This is a hard cap even if `token_ttl` and `token_max_ttl` would otherwise allow a renewal.
      token_num_uses:
        The period, if any, in number of seconds to set on the token.
      token_policies:
        List of policies to encode onto generated tokens. 
        Depending on the auth method, this list may be supplemented by user/group/other values.
      token_bound_cidrs:
        List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well.
      token_no_default_policy:
        If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies.
    DOC
}

variable "postgres_connection_url" {
  type        = string
  sensitive   = true
  description = "A URL containing connection information. For example: `postgres://username:password@host:port/database`"
}

variable "postgres_ttl_settings" {
  type = object({
    default_ttl = optional(number)
    max_ttl     = optional(number)
  })
  default = {
    default_ttl = 3600
    max_ttl     = 4800
  }
  description = <<-DOC
    default_ttl:
      The default number of seconds for leases for this role.
    max_ttl:
      The maximum number of seconds for leases for this role.
  DOC
}

variable "postgres_creation_statements" {
  type        = list(string)
  description = "The postgres database statements to execute when creating a user."
  default = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO \"{{name}}\";",
    "GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public to \"{{name}}\";"
  ]
}

variable "postgres_revocation_statements" {
  type        = list(string)
  default     = ["ALTER ROLE \"{{name}}\" NOLOGIN;"]
  description = "The postgres database statements to execute when revoking a user."
}

variable "postgres_renew_statements" {
  type        = list(string)
  default     = ["ALTER ROLE \"{{name}}\" VALID UNTIL '{{expiration}}';"]
  description = "The postgres database statements to execute when renewing a user."
}
