#!/usr/bin/env bash

vault operator init -format=json -key-shares=1 -key-threshold=1 > vault.init.json
vault operator unseal $(jq -r .unseal_keys_hex[] < vault.init.json)
vault login $(jq -r .root_token < vualt.init.json)

