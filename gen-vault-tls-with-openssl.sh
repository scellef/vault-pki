#!/usr/bin/env bash
. functions.sh

# 1. Create CA key
openssl genrsa -out ./vault.ca.key 2048

# 2. Create CA cert
create_ca_conf

openssl req -config vault.ca.conf \
  -key vault.ca.key \
  -new -x509 -days 7300 -sha256 \
  -extensions v3_ca -subj "/CN=Vault CA" \
  -out vault.ca.crt

# 3. Create server key
openssl genrsa -out ./vault.key 2048

# 4. Create server CSR
create_server_csr

openssl req -new -subj "/CN=vault.local" \
  -extensions v3_req \
	-key vault.key -out vault.csr -config vault.conf

# 5. Issue server certificate
openssl x509 -req -CA vault.ca.crt -CAkey vault.ca.key -CAcreateserial \
  -in vault.csr -days 395 -out vault.crt -extensions v3_req -extfile vault.conf

# 6. Create client key
openssl genrsa -out ./vault.client.key 2048

# 7. Create client CSR
create_client_csr

openssl req -new -subj "/CN=vault.client" \
  -extensions v3_req \
	-key vault.client.key -out vault.client.csr -config vault.client.conf

# 8. Issue client certificate
openssl x509 -req -CA vault.ca.crt -CAkey vault.ca.key -CAcreateserial \
  -in vault.client.csr -days 395 -out vault.client.crt -extensions v3_req \
  -extfile vault.client.conf
