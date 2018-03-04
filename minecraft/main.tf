resource "null_resource" "provisioner" {
  triggers {
    var_user                     = "${var.connection_user}"
    var_host                     = "${var.connection_host}"
    var_private_key              = "${sha1("${var.connection_private_key}")}"
    var_port                     = "${var.connection_port}"
    var_minecraft_download_url   = "${var.minecraft_download_url}"
    var_module_name              = "${var.module_name}"
    var_module_install_basedir   = "${var.module_install_basedir}"
    var_minecraft_data_subdir    = "${var.minecraft_data_subdir}"
    var_minecraft_data_symlink   = "${var.minecraft_data_symlink}"
    var_minecraft_backup_enabled = "${var.minecraft_backup_enabled}"
    var_minecraft_port           = "${var.minecraft_port}"
    var_remote_resource_dir      = "${var.remote_resource_dir}"
    var_dpkg_timeout_s           = "${var.dpkg_timeout_s}"

    file_main_tf                       = "${sha1("${file("${path.module}/main.tf")}")}"
    file_variables_tf                  = "${sha1("${file("${path.module}/variables.tf")}")}"
    file_provision_sh                  = "${sha1("${file("${path.module}/provision.sh")}")}"
    file_install_minecraft_sh          = "${sha1("${file("${path.module}/install-minecraft.sh")}")}"
    file_generate_config_json_sh       = "${sha1("${file("${path.module}/generate-config-json.sh")}")}"
    file_generate_server_properties_sh = "${sha1("${file("${path.module}/generate-server-properties.sh")}")}"
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
    content = <<PROPERTIES
# generated on deployment from ${path.module}
module_name='${var.module_name}'
module_install_basedir='${var.module_install_basedir}'
module_install_dir='${var.module_install_basedir}/${var.module_name}'
module_install_log='${var.module_install_log}'
minecraft_download_url='${var.minecraft_download_url}'
minecraft_min_ram='${var.minecraft_min_ram}'
minecraft_max_ram='${var.minecraft_max_ram}'
minecraft_install_script='${var.minecraft_install_script}'
minecraft_start_script='${var.minecraft_start_script}'
minecraft_settings_script='${var.minecraft_settings_script}'
minecraft_eula='${var.minecraft_eula}'
minecraft_local_config='${var.minecraft_local_config}'
minecraft_local_config_path='${var.module_install_basedir}/${var.module_name}/${var.minecraft_local_config}'
minecraft_backup_enabled='${var.minecraft_backup_enabled}'
minecraft_property_file='${var.minecraft_property_file}'
minecraft_property_file_path='${var.module_install_basedir}/${var.module_name}/${var.minecraft_property_file}'
minecraft_property_difficulty='${var.minecraft_property_difficulty}'
minecraft_property_motd='${var.minecraft_property_motd}'
minecraft_data_subdir='${var.minecraft_data_subdir}'
minecraft_data_symlink='${var.minecraft_data_symlink}'
dpkg_timeout_s='${var.dpkg_timeout_s}'
PROPERTIES

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
