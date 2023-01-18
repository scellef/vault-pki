#!/usr/bin/env bash

vault auth enable cert
vault write auth/cert/certs/client \
  display_name=client \
  policies=default \
  certificate=@vault.client.crt \
  ttl=1h
