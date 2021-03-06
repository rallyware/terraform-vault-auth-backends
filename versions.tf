terraform {
  required_version = ">= 1.0"

  experiments = [module_variable_optional_attrs]

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.0"
    }
  }
}
