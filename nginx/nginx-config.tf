data "template_file" "nginx-config" {
  template_file = "${file("nginx-config.tmpl")}"

  vars {
    nginx_config_http_port                    = "${var.nginx_config_http_port}"
    nginx_config_https_port                   = "${var.nginx_config_https_port}"
    nginx_config_https_certificate_chain_path = "${var.nginx_config_https_certificates_directory}/${nginx_config_https_certificate_chain_rel_path}"
    nginx_config_https_key_path               = "${var.nginx_config_https_certificates_directory}/${var.nginx_config_https_key_rel_path}"
    nginx_config_https_root_bundle_path       = "${var.nginx_config_https_root_bundle_path}"
  }
}
