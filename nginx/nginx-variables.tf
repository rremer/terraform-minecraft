variable "nginx_config_target" {
  type        = "string"
  default     = "/etc/nginx.conf"
  description = "Path to an nginx configuration to generate."
}

variable "nginx_config_http_port" {
  type        = "string"
  default     = "80"
  description = "TCP port to listen on for HTTP traffic."
}

variable "nginx_config_https_port" {
  type        = "string"
  default     = "443"
  description = "TCP port to listen on for HTTPS traffic."
}

variable "nginx_config_https_certificates_directory" {
  type        = "string"
  default     = "/etc/nginx/ssl.d"
  description = "Path to a directory of ssl certificates."
}

variable "nginx_config_https_certificate_chain_rel_path" {
  type        = "string"
  default     = "chain.pem"
  description = "Path to the SSL certificate chain in PEM format."
}

variable "nginx_config_https_key_rel_path" {
  type        = "string"
  default     = "key.pem"
  description = "Path to the SSL private key in PEM format."
}

variable "nginx_config_https_key_pem" {
  type        = "string"
  description = "SSL private key in PEM format"
}

variable "nginx_config_https_certificate_pem" {
  type        = "string"
  description = "SSL public certificate in PEM format"
}

variable "nginx_config_https_intermediary_pem" {
  type        = "string"
  description = "SSL public signing/intermediary certificate in PEM format"
}

variable "nginx_config_https_root_bundle_path" {
  type        = "string"
  default     = "/etc/ssl/certs/ca-certificates.crt"
  description = "Path to the root certificate authorities bundle."
}
