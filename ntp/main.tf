resource "null_resource" "provisioner" {
  triggers {
    var_user                = "${var.connection_user}"
    var_host                = "${var.connection_host}"
    var_private_key         = "${sha1("${var.connection_private_key}")}"
    var_port                = "${var.connection_port}"
    var_ntp_timezone        = "${var.ntp_timezone}"
    var_ntp_peers           = "${join(" ", var.ntp_peers)}"
    var_remote_resource_dir = "${var.remote_resource_dir}"
    var_dpkg_timeout_s      = "${var.dpkg_timeout_s}"

    file_provision_sh     = "${sha1("${file("${path.module}/provision.sh")}")}"
    file_configure_ntp_sh = "${sha1("${file("${path.module}/configure-ntp.sh")}")}"
  }

  connection {
    user        = "${var.connection_user}"
    host        = "${var.connection_host}"
    private_key = "${var.connection_private_key}"
    port        = "${var.connection_port}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p ${var.remote_resource_dir}/${var.module_name}",
      "sudo chown -R ${var.connection_user} ${var.remote_resource_dir}/${var.module_name}",
    ]
  }

  provisioner "file" {
    content = "
# generated on deployment from ${path.module}
module_name='${var.module_name}'
module_install_basedir='${var.module_install_log}'
module_install_log='${var.module_install_log}'
dpkg_timeout_s='${var.dpkg_timeout_s}'
ntp_timezone='${var.ntp_timezone}'
ntp_peers='${null_resource.provisioner.triggers["var_ntp_peers"]}'
"

    destination = "${var.remote_resource_dir}/${var.module_name}/${var.module_properties}"
  }

  provisioner "file" {
    source      = "${path.module}/"
    destination = "${var.remote_resource_dir}/${var.module_name}/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash ${var.remote_resource_dir}/${var.module_name}/provision.sh ${var.module_properties}",
    ]
  }
}
