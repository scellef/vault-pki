#!/usr/bin/env bash

LIST_OF_FILES="
  ./*.key
  ./*.crt
  ./*.csr
  ./*.conf
  ./*.json
  ./*.srl
  ./vault.db
  ./node-id
"

rm -f $LIST_OF_FILES
rm -rf ./raft/
