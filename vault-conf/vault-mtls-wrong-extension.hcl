ui = true

storage "raft" {
  path = "./"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "./vault.client.crt"
  tls_key_file  = "./vault.client.key"
  tls_require_and_verify_client_cert = true
  tls_client_ca_file = "./vault.ca.crt"
}

listener "tcp" {
  address     = "0.0.0.0:8202"
  tls_disable = "true"
}

license_path = "./vault.hclic"

cluster_name = "development"
api_addr = "https://localhost:8200"
cluster_addr = "https://localhost:8201"

telemetry {
  dogstatsd_addr = "localhost:8125"
  prometheus_retention_time = "30s"
  disable_hostname = true
}

disable_mlock = true
log_level = "trace"
log_requests_level = "info"
raw_storage_endpoint = true
