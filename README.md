# Overview

This is a series of helper functions for quickly generating a private CA, server & client certificate and key-pair for demonstrating Vault TLS configuration, TLS auth method, and PKI secrets engine.

# Requirements

* A recent version of `openssl`
  * If running on MacOS, you'll probably be better served using the version of `openssl` available in Homebrew:

  ```
  brew install openssl
  ```

* A valid Vault Enterprise license file: `./vault.hclic`

# Files

**`gen-vault-tls-with-openssl.sh`**

* Generate a private key used for creating a self-signed CA certificate, which will in turn issue a server and client certificate for a local Vault instance using `openssl`

**`gen-vault-tls-with-vault.sh`**

* Starts a [Vault dev server](https://developer.hashicorp.com/vault/docs/concepts/dev-server) and enables the PKI secrets engine, which will then generate a private key used for creating a self-signed CA certificate, which will in turn issue a server and client certificate identical to the certificates issued via `openssl`

**`configure-tls-auth.sh`**

* Enables the TLS Certificate auth method in a running Vault server, and configures a trusted key for authentication using the client certificate generated with `gen-vault-tls-with-openssl.sh`.

**`init.sh`**

* Initializes a Vault server with a single Shamir unseal key.

**`cleanup.sh`**

* Removes artifacts and locally instantiated Vault databases generated in this directory

**`functions.sh`**

* Writes needed `openssl` configuration and CSR files used by `gen-vault-tls-with-openssl.sh`

**`vault-conf/`**

* Vault configuration files demonstrating different TLS `listener` configurations
