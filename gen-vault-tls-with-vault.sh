#!/usr/bin/env bash

# 0. Start Vault dev server
vault server -dev -dev-root-token-id root &
VAULT_PID="$!"
sleep 2

export VAULT_ADDR=http://localhost:8200

# 1. Enable PKI secrets engine
vault secrets enable pki

# 2. Generate root key and cert
vault write -format=json pki/root/generate/internal common_name="Vault CA" \
  > vault.ca.json

# 3. Generate server key and cert
vault write -format=json pki/roles/vault allowed_domains=vault.local,vault \
  allow_localhost=true \
  allow_bare_domains=true \
  server_flag=true \
  client_flag=false
vault write -format=json pki/issue/vault ttl=24h \
  common_name=vault.local \
  alt_names=vault,localhost \
  ip_sans=127.0.0.1 \
  > vault.server.json

# 4. Generate client key and cert
vault write -format=json pki/roles/vault-client allowed_domains=vault.local,vault \
  allow_localhost=true \
  allow_bare_domains=true \
  server_flag=false \
  client_flag=true
vault write -format=json pki/issue/vault-client ttl=24h \
  common_name=vault.local \
  alt_names=vault,localhost \
  ip_sans=127.0.0.1 \
  > vault.client.json

read -p "Hit enter to clean up dev server: "
kill -15 $VAULT_PID || kill -9 $VAULT_PID
