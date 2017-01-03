resource "null_resource" "provisioner" {
  triggers {
    var_user                   = "${var.connection_user}"
    var_host                   = "${var.connection_host}"
    var_private_key            = "${sha1("${var.connection_private_key}")}"
    var_port                   = "${var.connection_port}"
    var_module_name            = "${var.module_name}"
    var_module_install_basedir = "${var.module_install_basedir}"
    var_remote_resource_dir    = "${var.remote_resource_dir}"
    var_backup_user            = "${var.backup_user}"
    var_interval_minutes       = "${var.interval_minutes}"
    var_keep_days              = "${var.keep_days}"
    var_s3_config_path         = "${var.s3_config_path}"
    var_backup_directory       = "${var.backup_directory}"
    var_backup_rate_limit_kbs  = "${var.backup_rate_limit_kbs}"
    var_dpkg_timeout_s         = "${var.dpkg_timeout_s}"

    file_provision_sh          = "${sha1("${file("${path.module}/provision.sh")}")}"
    file_configure_backup_sh   = "${sha1("${file("${path.module}/configure-backup.sh")}")}"
    file_s3_backup_sh          = "${sha1("${file("${path.module}/s3-backup.sh")}")}"
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
module_install_basedir='${var.module_install_basedir}'
module_install_log='${var.module_install_log}'
interval_minutes='${var.interval_minutes}'
keep_days='${var.keep_days}'
backup_directory='${var.backup_directory}'
backup_script_path='${var.remote_resource_dir}/${var.module_name}/s3-backup.sh'
backup_rate_limit_kbs='${var.backup_rate_limit_kbs}'
dpkg_timeout_s='${var.dpkg_timeout_s}'
backup_user='${var.backup_user}'
s3_config_path='${var.s3_config_path}'
s3_username='${aws_iam_access_key.backup.user}'
s3_bucket='${var.backup_endpoint}'
s3_access_key_id='${aws_iam_access_key.backup.id}'
s3_access_secret='${aws_iam_access_key.backup.secret}'
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

resource "aws_s3_bucket" "backup" {
  bucket = "${var.backup_endpoint}"
  acl    = "${var.bucket_acl}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_iam_user" "backup" {
  name = "${var.backup_endpoint}"
}

data "template_file" "iam-policy" {
  template = "${file("${path.module}/iam-policy.json.tpl")}"

  vars {
    bucket_arn = "${aws_s3_bucket.backup.arn}"
  }
}

resource "aws_iam_user_policy" "backup" {
  name   = "${var.module_name}"
  user   = "${aws_iam_user.backup.name}"
  policy = "${data.template_file.iam-policy.rendered}"
}

resource "aws_iam_access_key" "backup" {
  user = "${aws_iam_user.backup.name}"
}
