resource "null_resource" "provisioner" {
  triggers {
    connection_user          = "${var.connection_user}"
    connection_host          = "${var.connection_host}"
    connection_private_key   = "${sha1("${var.connection_private_key}")}"
    connection_port          = "${var.connection_port}"
    minecraft_download_url   = "${var.minecraft_download_url}"
    module_install_basedir   = "${var.module_install_basedir}"
    minecraft_data_subdir    = "${var.minecraft_data_subdir}"
    minecraft_data_symlink   = "${var.minecraft_data_symlink}"
    minecraft_backup_enabled = "${var.minecraft_backup_enabled}"
    minecraft_port           = "${var.minecraft_property_port}"

    main_tf                = "${sha1("${file("${path.module}/main.tf")}")}"
    variables_tf           = "${sha1("${file("${path.module}/minecraft-variables.tf")}")}"
    provision_sh           = "${sha1("${file("${path.module}/provision.sh")}")}"
    install_minecraft_sh   = "${sha1("${file("${path.module}/install-minecraft.sh")}")}"
    generate_properties_sh = "${sha1("${file("${path.module}/generate-properties.sh")}")}"
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

minecraft_download_url='${var.minecraft_download_url}'
minecraft_install_script='${var.minecraft_install_script}'

minecraft_data_subdir='${var.minecraft_data_subdir}'
minecraft_data_symlink='${var.minecraft_data_symlink}'

minecraft_eula='${var.minecraft_eula}'
minecraft_start_script='${var.minecraft_start_script}'
minecraft_start_properties='${var.minecraft_start_properties}'

# backup properties
minecraft_backup_enabled='${var.minecraft_backup_enabled}'
minecraft_backup_hours_interval_float='${var.minecraft_backup_hours_interval_float}'
minecraft_backup_keep_int='${var.minecraft_backup_keep_int}'
minecraft_backup_compression='${var.minecraft_backup_compression}'
minecraft_backup_silent='${var.minecraft_backup_silent}'
minecraft_backup_data_dir='${var.minecraft_backup_data_dir}'

# java properties
java_install_directory='${var.java_install_directory}'
java_download_url='${var.java_download_url}'
java_min_ram='${var.java_min_ram}'
java_max_ram='${var.java_max_ram}'

# vanilla server properties
minecraft_property_file_template='${var.minecraft_property_file_template}'
minecraft_property_file_target='${var.minecraft_property_file_target}'
minecraft_property_file_target_path='${var.module_install_basedir}/${var.module_name}/${var.minecraft_property_file_target}'
minecraft_property_motd='${var.minecraft_property_motd}'
minecraft_property_difficulty='${var.minecraft_property_difficulty}'
minecraft_property_allow_flight='${var.minecraft_property_allow_flight}'
minecraft_property_port='${var.minecraft_property_port}'
minecraft_property_gamemode='${var.minecraft_property_gamemode}'
minecraft_property_level_seed='${var.minecraft_property_level_seed}'
minecraft_property_compression_threshold_bytes='${var.minecraft_property_compression_threshold_bytes}'
minecraft_property_level_type='${var.minecraft_property_level_type}'
PROPERTIES

    destination = "${var.module_resource_dir}/${var.module_name}/${var.module_properties}"
  }

  provisioner "file" {
    source      = "${path.module}/"
    destination = "${var.module_resource_dir}/${var.module_name}/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash ${var.module_resource_dir}/${var.module_name}/provision.sh ${var.module_properties}",
    ]
  }
}
