resource "null_resource" "provisioner" {
  triggers {
    connection_user                     = "${var.connection_user}"
    connection_host                     = "${var.connection_host}"
    connection_private_key              = "${sha1("${var.connection_private_key}")}"
    connection_port                     = "${var.connection_port}"
    module_install_basedir              = "${var.module_install_basedir}"
    nginx_http_port                     = "${var.nginx_http_port}"
    nginx_https_port                    = "${var.nginx_https_port}"
    nginx_config_https_key_pem          = "${sha256("${var.nginx_config_https_key_pem}")}"
    nginx_config_https_certificate_pem  = "${sha256("${var.nginx_config_https_certificate_pem}")}"
    nginx_config_https_intermediary_pem = "${sha256("${var.nginx_config_https_intermediary_pem}")}"

    main_tf          = "${sha1("${file("${path.module}/main.tf")}")}"
    variables_tf     = "${sha1("${file("${path.module}/nginx-variables.tf")}")}"
    provision_sh     = "${sha1("${file("${path.module}/provision.sh")}")}"
    install_nginx_sh = "${sha1("${file("${path.module}/install-nginx.sh")}")}"
  }

  connection {
    user        = "${var.connection_user}"
    host        = "${var.connection_host}"
    private_key = "${var.connection_private_key}"
    port        = "${var.connection_port}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p ${var.module_resource_dir}/${var.module_name}",
      "sudo chown -R ${var.connection_user} ${var.module_resource_dir}/${var.module_name}",
      "sudo mkdir -p ${var.nginx_config_https_certificates_directory}",
      "sudo chown -R ${var.connection_user} ${var.nginx_config_https_certificates_directory}",
    ]
  }

  provisioner "file" {
    content = <<PROPERTIES
# generated on deployment from ${path.module}

# general module properties
module_name='${var.module_name}'
module_install_basedir='${var.module_install_basedir}'
module_install_dir='${var.module_install_basedir}/${var.module_name}'
module_install_log='${var.module_install_log}'
module_dpkg_timeout_s='${var.module_dpkg_timeout_s}'

# nginx properties
nginx_config_https_certificates_directory='${var.nginx_config_https_certificates_directory}'
PROPERTIES

    destination = "${var.module_resource_dir}/${var.module_name}/${var.module_properties}"
  }

  provisioner "file" {
    source      = "${path.module}/"
    destination = "${var.module_resource_dir}/${var.module_name}/"
  }

  provisioner "file" {
    content     = "${var.nginx_config_https_key_pem}"
    destination = "${var.nginx_config_https_certificates_directory}/${var.nginx_config_https_key_rel_path}"
  }

  provisioner "file" {
    content = <<HEREDOC
${var.nginx_config_https_certificate_pem}
${var.nginx_config_https_intermediary_pem}
HEREDOC

    destination = "${var.nginx_config_https_certificates_directory}/${var.nginx_config_https_certificate_chain_rel_path}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash ${var.module_resource_dir}/${var.module_name}/provision.sh ${var.module_properties}",
    ]
  }
}
